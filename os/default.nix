{
  config,
  pkgs,
  lib,
  ...
}: {
  # WARNING: do not touchy
  system.stateVersion = "23.05";

  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        useOSProber = true;
        devices = ["nodev"];
        fontSize = 30;
      };
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot";
      };
      timeout = 10;
    };
    plymouth = {
      enable = true;
      theme = "breeze";
    };
    consoleLogLevel = 0; # reduce console logs
    initrd.verbose = false; # reduce initrd output
    initrd.systemd.enable = true; # use initrd, apparently spawning plymouth faster
    kernelParams = [
      "quiet" # ask quiet
      "fbcon=nodefer" # do not use vendor logo
      # "splash"
      # "vga=current"
      "loglevel=3" # only produce errors and worse
      "udev.log_level=3" # same as above
      "rd.udev.log_level=3" # same as above for initrd
      "rd.systemd.show_status=false" # hide systemd messages
      "vt.global_cursor_default=0" # remove cursor blink
    ];
  };

  powerManagement.enable = true;
  services.thermald.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=10m
    HibernateMode=shutdown
  ''; # systemd-suspend-then-hibernate delay to hibernation
  systemd.services.fix-button-after-hibernate = {
    # it is needed after terminating (by crashing?) user session and redoing login
    description = "Reload ACPI Button Module After Hibernate";
    after = ["hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target"];
    wantedBy = ["hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "${pkgs.kmod}/bin/modprobe -r button"
        "${pkgs.kmod}/bin/modprobe button"
      ];
    };
  };

  networking = {
    hostName = "kafka";
    networkmanager = {
      enable = true;
      ethernet = {
        macAddress = "random";
      };
      wifi = {
        macAddress = "random";
        scanRandMacAddress = true;
      };
    };
  };

  time.timeZone = "UTC";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "C.UTF-8";
      LC_COLLATE = "C.UTF-8";
      LC_IDENTIFICATION = "C.UTF-8";
      LC_MEASUREMENT = "C.UTF-8";
      LC_MONETARY = "C.UTF-8";
      LC_NAME = "C.UTF-8";
      LC_NUMERIC = "C.UTF-8";
      LC_PAPER = "C.UTF-8";
      LC_TELEPHONE = "C.UTF-8";
      LC_TIME = "en_DK.UTF-8";
    };
  };

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # services.upower.ignoreLid = true;
  services.logind = {
    lidSwitch = "ignore";
    powerKey = "ignore";
    rebootKey = "ignore";
    rebootKeyLongPress = "ignore";
    suspendKey = "ignore";
    suspendKeyLongPress = "ignore";
    hibernateKey = "ignore";
    hibernateKeyLongPress = "ignore";
  };

  services.gpm.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = false;
  };

  services.xserver = {
    enable = true;
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };
    # nixpkgs sddm uses a setup command hard-coding tty7 as the initial tty
    # forcing it flickers and moves it to tty1 (the right one), should be left to null when using sddm for it to work dynamically
    # no idea for gdm, don't wanna bother
    tty = null;
  };
  # programs.regreet.enable = false; # greetd
  # environment.noXlibs = true; # gdm relies on xlibs even with `wayland = true;`

  services.physlock.enable = false;

  services.getty = {
    greetingLine = ''> \l'';
    helpLine = "";
  };

  programs = {
    hyprland = {
      enable = true;
      systemd.setPath.enable = true;
      withUWSM = false;
    };
    xwayland.enable = false;
  };

  hardware.graphics.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true; # https://github.com/NixOS/nixpkgs/issues/160923
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.ubuntu
  ];

  security = {
    polkit.enable = true;
    pam.services.hyprlock = {};
    # sudo.enable = false;
    # sudo-rs.enable = true; # not stable yet, wait for audit
    # please.enable = true; # slow maintenance
    # doas.enable = true; # no doasedit
    # nitrokey.enable = true;
    # lockKernelModules = true; # no usb hotswap
    # protectKernelImage = true; # no kexec, WARNING: no hibernation!
  };

  # WARNING: Requires imperative setup first! Is experimental and highly unstable and incompatible with GRUB!
  # see https://nixos.wiki/wiki/Secure_Boot
  # boot.bootspec.enable = true;

  users.users = {
    u = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "code"];
      shell =
        config.programs.fish.package;
    };
  };

  system.tools = {
    nixos-enter.enable = false;
    nixos-option.enable = false;
    nixos-install.enable = false;
    nixos-rebuild.enable = false;
    # nixos-version.enable = false;
    nixos-build-vms.enable = false;
    nixos-generate-config.enable = false;
  };
  boot.enableContainers = false;
  nixpkgs.config.allowUnfree = false;
  programs = {
    fish = {
      enable = true;
      package = pkgs
        .fish
        .overrideAttrs (oldAttrs: {
        desktopItem = null;
        postInstall =
          oldAttrs.postInstall
            or ""
          + "rm -f $out/share/applications/fish.desktop";
      });
      useBabelfish = true;
    };
    nano.enable = false;
    command-not-found.enable = false;
  };
  # remove every xorg package until `services.xserver.enable = false` and `environment.noXlibs = true`
  services.xserver.excludePackages = with pkgs.xorg; [
    xorgserver.out
    xrandr
    xrdb
    setxkbmap
    iceauth
    xlsclients
    xset
    xsetroot
    xinput
    xprop
    xauth
    xf86inputevdev.out
    pkgs.xterm
  ];
  documentation.doc.enable = false; # remove nixos documentation desktopItem
  # documentation.info.enable = false; # perl present
  # documentation.nixos.enable = false; # perl present

  environment = {
    binsh = lib.getExe pkgs.dash;
    defaultPackages = []; # should be set to exclude instead of overwrite
    variables = {
      EDITOR = "kak";
      VISUAL = "kak";
    };
    systemPackages = with pkgs; [
      # WARNING: do NOT mkForce it will break, very badly
      kakoune
      networkmanager
      udiskie
      btop
      # libsForQt5.qt5.qtgraphicaleffects # sddm
      libsForQt5.qt5.qtwayland # xdg-open
    ];
  };
  # list executables via `ls -1  /run/current-system/sw/bin/ | sed -E 's%.*-> .{43}-%%g' | sort`
  environment.etc."current-system-packages".text = let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;

  services.fwupd.enable = true;
  services.udisks2.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true; # find a better spot! "connectivity"?

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };
  nix.channel.enable = false;
  nixpkgs.flake = {
    setNixPath = false;
    setFlakeRegistry = false;
  };
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
    use-xdg-base-directories = true;
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
