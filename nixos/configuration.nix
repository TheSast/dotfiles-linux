{
  # config,
  pkgs,
  lib,
  ...
}: {
  # WARNING: do not touchy
  system.stateVersion = "23.05";

  ## Boot
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        useOSProber = true;
        devices = ["nodev"];
        fontSize = 20;
        # font = font-stuff;
        # splashImage = "/my/dynamic/background.png" # would be nice for it to be dynamic
        # theme = pkgs.my-theme # would be nice for it to be dynamic
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
  };

  ## Laptop
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
  # TODO: set each key
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=10m
    HibernateMode=shutdown
  '';

  ## Necessary
  networking = {
    hostName = "charlie";
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

  ## Input devices
  services.xserver = {
    layout = "us";
    xkbVariant = "";
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

  # services.xserver.libinput.enable = true;

  # console = {
  # earlySetup = true;
  # keyMap = "us"; # def
  # useXkbConfig = true;
  # packages = with pkgs; [ ]; # add font and gpm? here
  # };

  # services.kmscon = {
  #   enable = true;
  #   hwRender = true;
  #   fonts = [ { font stuff }];
  # };

  ## Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = false;
  };

  ## GUI
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
  # environment.noXlibs = true;

  services.physlock.enable = false;

  services.getty = {
    greetingLine = ''> \l'';
    helpLine = "";
  };

  programs = {
    hyprland = {
      enable = true;
      systemd.setPath.enable = true;
      withUWSM = true;
    };
    xwayland.enable = false;
  };

  hardware.opengl.enable = true;

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
    nerdfonts
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

  ## Users
  users.users = {
    u = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "code"];
      shell = pkgs.fish;
    };
    s = {
      isSystemUser = true;
      group = "users";
      createHome = true;
      home = "/home/s";
      useDefaultShell = true;
      homeMode = "710";
      extraGroups = ["code"];
    };
  };

  ## Programs and Packages
  nixpkgs.config.allowUnfree = false;
  programs = {
    fish = {
      enable = true;
      useBabelfish = true;
    };
    # kdeconnect.enable = true;
    nano.enable = false;
  };

  services.xserver.excludePackages = [pkgs.xterm];
  documentation.doc.enable = false;

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
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

  ## Services, timers and jobs
  services.fwupd.enable = true;
  services.udisks2.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true; # find a better spot! "connectivity"?
  # nix.optimise = {
  #   automatic = true;
  #   dates = ["daily"];
  # };
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

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
