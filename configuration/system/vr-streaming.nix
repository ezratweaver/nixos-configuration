{ pkgs, ... }:

let
  gnirehtet = pkgs.stdenvNoCC.mkDerivation {
    pname = "gnirehtet-java";
    version = "2.5.1";
    src = pkgs.fetchurl {
      url = "https://github.com/Genymobile/gnirehtet/releases/download/v2.5.1/gnirehtet-java-v2.5.1.zip";
      sha256 = "816748078fa6a304600a294a13338a06ac778bcc0e57b62d88328c7968ad2d3a";
    };
    nativeBuildInputs = [
      pkgs.unzip
      pkgs.makeWrapper
    ];
    installPhase = ''
      runHook preInstall
      mkdir -p "$out/share/gnirehtet" "$out/bin"
      cp gnirehtet.jar gnirehtet.apk "$out/share/gnirehtet/"
      # The release JAR uses Java 11 bytecode (class version 55).
      makeWrapper ${pkgs.jre11_minimal}/bin/java "$out/bin/gnirehtet" \
        --add-flags "-jar $out/share/gnirehtet/gnirehtet.jar" \
        --set ADB ${pkgs.android-tools}/bin/adb \
        --set GNIREHTET_APK "$out/share/gnirehtet/gnirehtet.apk"
      runHook postInstall
    '';
  };

  quest-link = pkgs.writeShellApplication {
    name = "quest-link";
    runtimeInputs = [
      gnirehtet
      pkgs.android-tools
      pkgs.coreutils
      pkgs.gnugrep
      pkgs.util-linux
    ];
    text = ''
      if (( $# > 1 )); then
        echo "Usage: quest-link [USB_SERIAL]" >&2
        exit 2
      fi
      command -v adb >/dev/null || { echo "ADB is missing." >&2; exit 1; }
      serial="''${1:-}"
      requested="$serial"
      relay_pid=""
      client_started=false
      wifi_changed=false
      log_dir=$(mktemp -d)

      device_adb() { timeout --kill-after=2 5 adb -s "$serial" "$@"; }
      fail() { echo "quest-link: $*" >&2; exit 1; }
      cleanup() {
        result=$?
        trap - EXIT
        trap "" INT TERM
        set +e
        if $client_started; then
          echo "Stopping Quest link..."
          if ! device_adb get-state >/dev/null 2>&1; then
            echo "USB disconnected. Waiting up to 10 seconds for reconnection..."
            timeout --kill-after=2 10 adb -s "$serial" wait-for-device
          fi
          if $wifi_changed; then
            device_adb shell svc wifi enable || echo "Could not restore Wi-Fi. Enable it in the headset." >&2
          fi
          timeout --kill-after=2 5 gnirehtet stop "$serial"
          device_adb reverse --remove localabstract:gnirehtet
        fi
        if [[ -n "$relay_pid" ]]; then
          kill "$relay_pid" 2>/dev/null
          for ((i=0; i<20; i++)); do
            kill -0 "$relay_pid" 2>/dev/null || break
            sleep 0.1
          done
          kill -KILL "$relay_pid" 2>/dev/null
          wait "$relay_pid" 2>/dev/null
        fi
        if (( result != 0 )) && [[ -f "$log_dir/relay.log" ]]; then
          tail -n 30 "$log_dir/relay.log" >&2
        fi
        rm -rf "$log_dir"
        exit "$result"
      }
      trap cleanup EXIT
      trap 'exit 130' INT
      trap 'exit 143' TERM
      exec 9>"''${XDG_RUNTIME_DIR:-/tmp}/quest-link-$UID.lock"
      flock -n 9 || fail "Another quest-link command is already running."
      timeout --kill-after=2 10 adb start-server || fail "Could not start ADB."

      echo "Waiting for an authorized USB device. Connect and unlock the Quest."
      last_status=""
      while :; do
        devices=$(timeout --kill-after=2 5 adb devices -l) || fail "Could not list ADB devices."
        candidates=()
        status="No matching USB device. Check the cable and USB debugging."
        while read -r id state details; do
          [[ " $details " == *" usb:"* ]] || continue
          [[ -z "$requested" || "$id" == "$requested" ]] || continue
          candidates+=("$id")
          serial="$id"
          case "$state" in
            device) status=ready ;;
            unauthorized) status="Accept the USB debugging prompt in the headset." ;;
            *) status="Device is $state. Reconnect it or check USB debugging." ;;
          esac
        done <<< "$devices"
        (( ''${#candidates[@]} <= 1 )) || fail "Several USB devices are connected. Use quest-link SERIAL. Connected serials: ''${candidates[*]}"
        [[ "$status" == ready ]] && break
        if [[ "$status" != "$last_status" ]]; then
          echo "$status"
          last_status="$status"
        fi
        sleep 1
      done

      mappings=$(device_adb reverse --list) || fail "Could not inspect ADB tunnels."
      if grep -q 'localabstract:gnirehtet' <<< "$mappings"; then
        fail "A gnirehtet tunnel already exists. Stop that session first."
      fi
      echo "Starting Java relay for $serial..."
      gnirehtet relay >"$log_dir/relay.log" 2>&1 &
      relay_pid=$!
      for ((i=0; i<100; i++)); do
        kill -0 "$relay_pid" 2>/dev/null || fail "The Java relay stopped during startup."
        grep -q 'Relay server started' "$log_dir/relay.log" && break
        sleep 0.1
      done
      grep -q 'Relay server started' "$log_dir/relay.log" || fail "The relay did not start within 10 seconds."
      client_started=true
      echo "Starting Android VPN. Accept the VPN prompt in the headset if shown."
      timeout --kill-after=2 30 gnirehtet start "$serial" || fail "Could not start the Android client."
      for ((i=0; i<60; i++)); do
        kill -0 "$relay_pid" 2>/dev/null || fail "The Java relay stopped."
        device_adb get-state >/dev/null 2>&1 || fail "USB disconnected during startup."
        grep -Eq 'Client #[0-9]+ connected' "$log_dir/relay.log" && break
        sleep 1
      done
      grep -Eq 'Client #[0-9]+ connected' "$log_dir/relay.log" || fail "No VPN tunnel after 60 seconds. Check the headset VPN prompt."
      grep -Eq 'Client #[0-9]+ disconnected' "$log_dir/relay.log" && fail "The VPN tunnel disconnected during startup."
      kill -0 "$relay_pid" 2>/dev/null || fail "The Java relay stopped."
      wifi_changed=true
      device_adb shell svc wifi disable || fail "Could not disable Quest Wi-Fi."
      echo "USB tunnel connected. Quest Wi-Fi disabled. Open Moonlight."
      echo "Keep this terminal open. Press Ctrl+C to stop and enable Quest Wi-Fi."
      while :; do
        kill -0 "$relay_pid" 2>/dev/null || fail "The Java relay stopped."
        device_adb get-state >/dev/null 2>&1 || fail "USB disconnected."
        grep -Eq 'Client #[0-9]+ disconnected' "$log_dir/relay.log" && fail "The VPN tunnel disconnected."
        sleep 1
      done
    '';
  };
in
{
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  environment.systemPackages = [ quest-link ];
}
