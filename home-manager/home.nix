{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "u";
    homeDirectory = "/home/u";

    # do not touchy
    stateVersion = "23.05";
  };

  nixpkgs.config = {
    allowUnfree = false;
    allowUnfreePredicate = pkg:
      builtins.elem (pkgs.lib.getName pkg) [
        "obsidian"
      ];
    permittedInsecurePackages = pkgs.lib.optional (builtins.any (e: e == pkgs.obsidian.version) ["1.4.16" "1.5.3"]) "electron-25.9.0";
  };
  home.packages = with pkgs; [
    babelfish
    bastet
    batsignal
    brightnessctl
    cliphist
    du-dust
    erdtree
    eww-wayland
    fd
    fzf
    gtklock
    gtklock-powerbar-module # should be in gtklock config
    hyprpicker
    libnotify
    neovide
    networkmanagerapplet
    obsidian # flat
    onefetch
    ouch
    pavucontrol
    playerctl
    polkit-kde-agent
    wallust
    ripgrep # prog
    rofi-wayland # prog
    skim # prog
    swayidle
    swayimg
    swaynotificationcenter
    swww
    tmux # prog
    tor-browser-bundle-bin
    trash-cli
    vieb
    waybar # prog
    wl-clipboard
    xdg-utils
    zellij
  ];

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = ["swayimg.desktop"];
        "image/jpg" = ["swayimg.desktop"];
        "image/jpeg" = ["swayimg.desktop"];
        "text/plain" = ["neovide.desktop"];
        "text/markdown" = ["neovide.desktop"];
        "text/x-log" = ["neovide.desktop"];
        "text/x-lua" = ["neovide.desktop"];
        "text/rust" = ["neovide.desktop"];
        "text/x-csrs" = ["neovide.desktop"];
        "text/x-chdr" = ["neovide.desktop"];
        "text/x-c++srs" = ["neovide.desktop"];
        "text/x-c++hdr" = ["neovide.desktop"];
        "text/x-matlab" = ["neovide.desktop"];
        "text/x-css" = ["neovide.desktop"];
        "text/x-scss" = ["neovide.desktop"];
        "application/x-shellscript" = ["neovide.desktop"];
        "application/xml" = ["neovide.desktop"];
        "application/json" = ["neovide.desktop"];
        "application/octet-stream" = ["neovide.desktop"];
        "application/x-desktop" = ["neovide.desktop"];
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
        source = ./alacritty;
      };
      astronvim = {
        source = ./astronvim;
      };
      bat = {
        source = ./bat;
      };
      bottom = {
        source = ./bottom;
      };
      erdtree = {
        source = ./erdtree;
      };
      neofetch = {
        source = ./neofetch;
      };
      npm = {
        source = ./npm;
      };
      readline = {
        source = ./readline;
      };
      starship = {
        source = ./starship;
      };
      tmux = {
        source = ./tmux;
      };
      tmux-powerline = {
        source = ./tmux-powerline;
      };
      waybar = {
        source = ./waybar;
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
    MANPAGER = "sh -c 'bat -l man -p'";
    NVIM_APPNAME = "astronvim";
    NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    INPUTRC = "${config.xdg.configHome}/readline/inputrc";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    STARSHIP_CONFIG = "${config.xdg.configHome}/starship/starship.toml";
  };

  # These are picked up by GDM and KDE Plasma (apparently?) but not by SDDM (which straight up loads your shell config) or other DMs
  systemd.user.sessionVariables = {
    XDG_DOCUMENTS_DIR = config.xdg.userDirs.documents;
    XDG_PICTURES_DIR = config.xdg.userDirs.pictures;
    XDG_DOWNLOAD_DIR = config.xdg.userDirs.download;
    XDG_DESKTOP_DIR = config.xdg.userDirs.desktop;
    XDG_VIDEOS_DIR = config.xdg.userDirs.videos;
    XDG_MUSIC_DIR = config.xdg.userDirs.music;
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
  programs.bash = {
    enable = false; # on will create ~/.bashrc
    historyFile = "${config.xdg.stateHome}/bash/history";
    historyControl = ["erasedups"];
  };
  programs.bat.enable = true;
  programs.bottom.enable = true;
  programs.btop.enable = true;
  programs.broot.enable = true;
  programs.eza = {
    enable = true;
  };
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
    '';
    functions = {
      bathelp = "$argv --help 2>&1 | bat --plain --language=help";
      cd = ''
        builtin cd $argv || return
        set current_repository (git rev-parse --show-toplevel 2> /dev/null)
        if [ "$current_repository" ] && \
          [ "$current_repository" != "$last_repository" ]
          onefetch --include-hidden
        end
        set -gx last_repository $current_repository
      '';
    };
    interactiveShellInit = ''
      function starship_transient_prompt_func
        echo "- "
      end

      functions -e l
      functions -e la
      functions -e ll
    '';
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "TheSast";
    userEmail = "27977196+TheSast@users.noreply.github.com";
    aliases = {
      track = "add --intent-to-add";
      unstage = "restore --staged";
      amend = "commit --amend";
    };
    extraConfig = {
      user.signingKey = "~/.ssh/id_ed25519.pub";
      advice.addEmptyPathspec = true;
      commit.gpgsign = true;
      core.pager = "bat"; # git log and similar should not use this
      gpg.format = "ssh";
      merge.conflictstyle = "diff3";
      init.defaultBranch = "main";
      "includeIf \"gitdir/i:~/workspace/school\"".path = "~/workspace/school/gitconfig";
    };
  };
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "rainbow";
      mode = "rgb";
      color_align = {
        mode = "horizontal";
      };
    };
  };
  programs.lazygit.enable = true;
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      alejandra
      commitlint
      deadnix
      gcc # treesitter
      gnumake # jsregexp for luasnip
      lua-language-server
      luajitPackages.luacheck
      nil
      statix
      stylua
    ];
  };
  programs.starship = {
    enable = true; # adds starship to PATH thus polluitng it
    enableFishIntegration = true;
    enableTransience = true;
  };
  programs.swaylock.enable = true;
  programs.swaylock.package = pkgs.swaylock-effects;
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.home-manager.enable = true;
}
