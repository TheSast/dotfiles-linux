{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d0dd1cfb-7040-4660-9ccc-8413835a5f6d";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/72CD-F395";
      fsType = "vfat";
    };

  # Swap for Hibernation and ZRAM due to low RAM
  swapDevices = [
    {
      label = "hiswap";
      device = lib.mkForce "/var/lib/hiswapfile";
      # priority = 1;
      size = 8 * 1024 + 64; # RAM + sqrt(RAM)
    }
  ];
  boot.resumeDevice = "/dev/disk/by-uuid/d0dd1cfb-7040-4660-9ccc-8413835a5f6d";
  boot.kernelParams = [ /* "mem_sleep_default=deep" */ /* "resume=UUID=d0dd1cfb-7040-4660-9ccc-8413835a5f6d" */ "resume_offset=6776832" ];
  zramSwap.enable = true;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
