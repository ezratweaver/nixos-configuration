{ pkgs, ... }:

{
  programs.dconf.enable = true;

  users.users.ezratweaver.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    libvirt-glib
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [
      53
      67
    ];
    allowedTCPPorts = [ 53 ];
    extraCommands = ''
      # Allow established/related connections
      iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT

      # Allow outbound traffic from VMs (virbr0) to anywhere
      iptables -I FORWARD -i virbr0 -j ACCEPT
    '';
  };

}
