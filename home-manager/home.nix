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
    desktopEntries = {
      Discord = {
        name = "Discord";
        # actions = {};
        genericName = "Messaging Platform";
        exec = "vieb --config-file=${config.xdg.configHome}/Vieb/Erwic/Discord/erwicrc --erwic=${config.xdg.configHome}/Vieb/Erwic/Discord/erwic.json --datafolder=${config.xdg.stateHome}/Erwic/Discord --ozone-platform-hint=auto";
        icon = "${config.xdg.configHome}/Vieb/Erwic/Discord/icon.png";
        terminal = false;
        type = "Application";
        # mimeType = [ "" ];
        # comment = "comment here";
        categories = ["Network" "Chat" "InstantMessaging"];
      };
      Element = {
        name = "Element";
        genericName = "Messaging Platform";
        exec = "vieb --config-file=${config.xdg.configHome}/Vieb/Erwic/Element/erwicrc --erwic=${config.xdg.configHome}/Vieb/Erwic/Element/erwic.json --datafolder=${config.xdg.stateHome}/Erwic/Element --ozone-platform-hint=auto";
        icon = "${config.xdg.configHome}/Vieb/Erwic/Element/icon.png";
        terminal = false;
        type = "Application";
        categories = ["Network" "Chat" "InstantMessaging"];
      };
      Bitwarden = {
        name = "Bitwarden";
        genericName = "Password Manager";
        exec = "vieb --config-file=${config.xdg.configHome}/Vieb/Erwic/Bitwarden/erwicrc --erwic=${config.xdg.configHome}/Vieb/Erwic/Bitwarden/erwic.json --datafolder=${config.xdg.stateHome}/Erwic/Bitwarden --ozone-platform-hint=auto";
        icon = "${config.xdg.configHome}/Vieb/Erwic/Bitwarden/icon.png";
        terminal = false;
        type = "Application";
        categories = ["Network"];
      };
      Protonmail = {
        name = "Proton Mail";
        genericName = "Electronic Mail Client";
        exec = "vieb --config-file=${config.xdg.configHome}/Vieb/Erwic/Proton_Mail/erwicrc --erwic=${config.xdg.configHome}/Vieb/Erwic/Proton_Mail/erwic.json --datafolder=${config.xdg.stateHome}/Erwic/Proton_Mail --ozone-platform-hint=auto";
        icon = "${config.xdg.configHome}/Vieb/Erwic/Proton_Mail/icon.png";
        terminal = false;
        type = "Application";
        categories = ["Network" "Email"];
      };
      YouTube = {
        name = "YouTube";
        genericName = "Video Streaming Platform";
        exec = "vieb --config-file=${config.xdg.configHome}/Vieb/Erwic/YouTube/erwicrc --erwic=${config.xdg.configHome}/Vieb/Erwic/YouTube/erwic.json --datafolder=${config.xdg.stateHome}/Erwic/YouTube --ozone-platform-hint=auto";
        icon = "${config.xdg.configHome}/Vieb/Erwic/YouTube/icon.png";
        terminal = false;
        type = "Application";
        categories = [
          "Network"
          /*
          "AudioVideo"
          */
        ]; # only one main category
      };
    };
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
        text = ''
          font:
            normal:
              family: FiraCode Nerd Font
              style: Medium
            bold:
              family: FiraCode Nerd Font
              style: Bold
            italic:
              family: FiraCode Nerd Font
              style: MediumItalic
            bold_italic:
              family: FiraCode Nerd Font
              style: BoldItalic
            size: 12

          hide_when_typing: true

          import:
            - ${config.xdg.cacheHome}/wallust/alacritty.yml
        '';
        target = "alacritty/alacritty.yml";
      };
      astronvim = {
        source = ./astronvim;
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
      scripts = {
        source = ./scripts;
      };
      starship = {
        source = ./starship;
      };
      swaylock = {
        source = ./swaylock;
      };
      tmux = {
        source = ./tmux;
      };
      tmux-powerline = {
        source = ./tmux-powerline;
      };
      Vieb = {
        source = ./Vieb;
        recursive = true;
      };
      Vieb-colorscheme = {
        text = ''
          source ${config.xdg.cacheHome}/colorscheme-dyn.vieb
          " Vieb config file generated by Nix
          " vim: ft=vim
        '';
        target = "Vieb/colorscheme.vieb";
      };
      wallust = {
        source = ./wallust;
        recursive = true;
      };
      wallust-toml = {
        text = ''
          backend = "fastresize"
          color_space = "labmixed"
          threshold = 20
          filter = "dark16"

          [[entry]]
          template = "alacritty.yml"
          target = "${config.xdg.cacheHome}/wallust/alacritty.yml"

          [[entry]]
          template = "tty.sh"
          target = "${config.xdg.cacheHome}/wallust/tty.sh"
        '';
        target = "wallust/wallust.toml";
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
    inherit (config.systemd.user.sessionVariables) VIEB_CONFIG_FILE VIEB_DATAFOLDER;
  };

  # These are picked up by GDM and KDE Plasma (apparently?) but not by SDDM (which straight up loads your shell config) or other DMs
  systemd.user.sessionVariables = {
    XDG_DOCUMENTS_DIR = config.xdg.userDirs.documents;
    XDG_PICTURES_DIR = config.xdg.userDirs.pictures;
    XDG_DOWNLOAD_DIR = config.xdg.userDirs.download;
    XDG_DESKTOP_DIR = config.xdg.userDirs.desktop;
    XDG_VIDEOS_DIR = config.xdg.userDirs.videos;
    XDG_MUSIC_DIR = config.xdg.userDirs.music;
    VIEB_CONFIG_FILE = "${config.xdg.configHome}/Vieb/viebrc";
    VIEB_DATAFOLDER = "${config.xdg.stateHome}/Vieb";
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
  programs.bat = {
    enable = true;
    config = {
      theme = "ansi";
    };
  };
  programs.btop.enable = true;
  programs.broot.enable = true;
  programs.eza = {
    enable = true;
    git = true;
    icons = true;
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
      sh ${config.xdg.cacheHome}/wallust/tty.sh
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
      nodePackages.vscode-json-languageserver # neoconf
      statix
      stylua
    ];
  };
  programs.starship = {
    enable = true; # adds starship to PATH thus polluitng it
    enableFishIntegration = true;
    enableTransience = true;
  };
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.home-manager.enable = true;
}
