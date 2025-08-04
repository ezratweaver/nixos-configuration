{ pkgs, ... }:


{
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemuPackage = pkgs.qemu_kvm;

  users.extraGroups.libvirtd.members = [ "ezratweaver" ];

  programs.virt-manager.enable = true;

  boot.kernelModules = [
    "kvm-intel"
    # "kvm-amd" # Uncomment for amd or intel
  ];

  networking.firewall.checkReversePath = false;
}

