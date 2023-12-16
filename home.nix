{ config, pkgs, ... }:

let
  unstablepkgs = import
    (builtins.fetchTarball {
      name = "nixos-unstable-2023-08-30";
      url = "https://github.com/nixos/nixpkgs/archive/3efb0f6f404ec8dae31bdb1a9b17705ce0d6986e.tar.gz";
      sha256 = "0a5vjzlbkgxv80r4cba3gdmdbd7vccg11kbsn71bjkfc0pkajyyb";
    })
    { config = config.nixpkgs.config; };
  unstablerpkgs =
    import
    (builtins.fetchTarball {
      name = "nixos-unstable-2023-12-08";
      url = "https://github.com/nixos/nixpkgs/archive/b8eebcad828c07879009bce5e3faa4906bb2fabd.tar.gz";
      sha256 = "0v1wj9hwg7xghs5pb487y16j0cl2pdxpfjawndvgm9gfdghgv1zd";
    })
    {config = config.nixpkgs.config;};
in {
  home.username = "u";
  home.homeDirectory = "/home/u";

  # do not touchy
  home.stateVersion = "23.05";

  nixpkgs.config = {
    allowUnfree = false;
    allowUnfreePredicate = pkg:
      builtins.elem (pkgs.lib.getName pkg) [
        "obsidian"
      ];
  };
  home.packages = with pkgs; [
    obsidian # flat
    pavucontrol # flat

    tor-browser-bundle-bin
    vieb
    unstablepkgs.neovide
    zellij
    swaylock-effects # prog
    gtklock
    gtklock-powerbar-module # should be in gtklock config
    swayimg
    networkmanagerapplet
    brightnessctl
    polkit-kde-agent

    tmux # prog
    bastet

    babelfish
    xdg-utils
    trash-cli
    onefetch
    ripgrep # prog
    erdtree
    fzf
    skim # prog
    fd
    du-dust
    ouch

    wl-clipboard
    unstablepkgs.waybar # prog
    cliphist
    eww-wayland
    rofi-wayland # prog
    swaynotificationcenter
    swayidle
    hyprpicker
    swww
    libnotify
    batsignal
    playerctl
  ];

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = [ "swayimg.desktop" ];
        "image/jpg" = [ "swayimg.desktop" ];
        "image/jpeg" = [ "swayimg.desktop" ];
        "text/plain" = [ "neovide.desktop" ];
        "text/markdown" = [ "neovide.desktop" ];
        "text/x-log" = [ "neovide.desktop" ];
        "text/x-lua" = [ "neovide.desktop" ];
        "text/rust" = [ "neovide.desktop" ];
        "text/x-csrs" = [ "neovide.desktop" ];
        "text/x-chdr" = [ "neovide.desktop" ];
        "text/x-c++srs" = [ "neovide.desktop" ];
        "text/x-c++hdr" = [ "neovide.desktop" ];
        "text/x-matlab" = [ "neovide.desktop" ];
        "text/x-css" = [ "neovide.desktop" ];
        "text/x-scss" = [ "neovide.desktop" ];
        "application/x-shellscript" = [ "neovide.desktop" ];
        "application/xml" = [ "neovide.desktop" ];
        "application/json" = [ "neovide.desktop" ];
        "application/octet-stream" = [ "neovide.desktop" ];
        "application/x-desktop" = [ "neovide.desktop" ];
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      templates = null;
      publicShare = null;
    };
    configFile = {
      alacritty = {
        source = .config/alacritty;
      };
      astronvim = {
        source = .config/astronvim;
      };
      bat = {
        source = .config/bat;
      };
      bottom = {
        source = .config/bottom;
      };
      erdtree = {
        source = .config/erdtree;
      };
      neofetch = {
        source = .config/neofetch;
      };
      npm = {
        source = .config/npm;
      };
      readline = {
        source = .config/readline;
      };
      starship = {
        source = .config/starship;
      };
      tmux = {
        source = .config/tmux;
      };
      tmux-powerline = {
        source = .config/tmux-powerline;
      };
    };
  };

  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "orchis-gtk3";
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  home.sessionVariables = {
    HISTFILE = config.programs.bash.historyFile;
    HISTCONTROL = builtins.concatStringsSep ":" config.programs.bash.historyControl;
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    VISUAL = "nvim";
    EDITOR = config.home.sessionVariables.VISUAL;
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    LESSHISTFILE = "${config.xdg.stateHome}/less/history";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    NVIM_APPNAME = "astronvim";
    NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    INPUTRC = "${config.xdg.configHome}/readline/inputrc";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    STARSHIP_CONFIG = "${config.xdg.configHome}/starship/starship.toml";
    VIEB_CONFIG_FILE = "${config.xdg.configHome}/Vieb/viebrc";
    VIEB_DATAFOLDER = "${config.xdg.stateHome}/Vieb";
  };

  # These are picked up by GDM and KDE Plasma (apparently?) but not by SDDM (which straight up loads your shell config) or other DMs
  systemd.user.sessionVariables = {
    NVIM_APPNAME = config.home.sessionVariables.NVIM_APPNAME;
    VISUAL = config.home.sessionVariables.VISUAL;
    EDITOR = config.home.sessionVariables.EDITOR;
  };
  home.shellAliases = {
    mv = "mv -i";
    clear = "clear -x";
    wget = "wget --hsts-file=${config.xdg.configHome}/wget-hsts";
  };

  programs.alacritty.enable = true;
  programs.bash.enable = false; # on will create ~/.bashrc
  programs.bash.historyFile = "${config.xdg.stateHome}/bash/history";
  programs.bash.historyControl = [ "erasedups" ];
  programs.bat.enable = true;
  programs.bottom.enable = true;
  programs.btop.enable = true;
  programs.broot.enable = true;
  programs.exa.enable = true;
  programs.fish.enable = true;
  programs.fish.shellInit = ''
    set fish_greeting
  '';
  programs.fish.functions = {
    bathelp = "$argv --help 2>&1 | bat --plain --language=help";
    cd = ''
      builtin cd $argv || return
      check_directory_new_repository
    '';
    check_directory_new_repository = ''
      set current_repository (git rev-parse --show-toplevel 2> /dev/null)
      if [ "$current_repository" ] && \
        [ "$current_repository" != "$last_repository" ]
        onefetch --include-hidden
      end
    '';
  };
  programs.fish.interactiveShellInit = ''
    function starship_transient_prompt_func
      echo "- "
    end
    enable_transience

    functions -e l
    functions -e la
    functions -e ll
  '';
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "TheSast";
    userEmail = "27977196+TheSast@users.noreply.github.com";
    aliases = {
      unstage = "restore --staged";
      amend = "commit --amend";
    };
    extraConfig = {
      user.signingKey = "~/.ssh/id_ed25519.pub";
      advice.addEmptyPathspec = true;
      commit.gpgsign = true;
      core.pager = "bat";
      gpg.format = "ssh";
      merge.conflictstyle = "diff3";
      "includeIf \"gitdir/i:~/workspace/school\"".path = "~/workspace/school/gitconfig";
    };
  };
  programs.hyfetch.enable = true;
  programs.lazygit.enable = true;
  programs.neovim = {
    enable = true;
    package = unstablerpkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      gcc # treesitter
      gnumake # jsregexp for luasnip
      commitlint
      lua-language-server
      stylua
      luajitPackages.luacheck
      nil
      alejandra
      deadnix
      statix
    ];
  };
  programs.starship.enable = true; # should not be in PATH
  programs.starship.enableFishIntegration = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableFishIntegration = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
