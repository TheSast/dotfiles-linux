{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  home = {
    username = "u";
    homeDirectory = "/home/u";

    # do not touchy
    stateVersion = "23.05";
  };

  nix = {
    gc = {
      automatic = true;
      frequency = "daily";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
    package = pkgs.nix; # should not be needed?
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
    alacritty
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
    hypridle
    hyprlock
    pkgs-unstable.hyprnotify # heavy CPU usage issues
    hyprpicker
    hyprpolkitagent
    libnotify
    neovide
    networkmanagerapplet
    obsidian # flat
    onefetch
    ouch
    pavucontrol
    playerctl
    ripgrep # prog
    rofi-wayland # prog
    skim # prog
    swayimg
    swaynotificationcenter
    swww
    tmux # prog
    tor-browser-bundle-bin
    trash-cli
    vieb
    waybar # prog
    (
      pkgs.writeShellApplication
      {
        name = "better-hyprshot";
        runtimeInputs = [coreutils jq slurp grim libnotify hyprpicker];
        text = builtins.readFile ./scripts/better-hyprshot.sh;
      }
    )
    wallust
    wl-clipboard
    xdg-utils
    wob
    zellij
  ];

  xdg = {
    enable = true;
    desktopEntries = {
      Discord = {
        name = "Discord";
        # actions = {};
        genericName = "Messaging Platform";
        exec = "vieb --config-file=${config.xdg.configHome}/Vieb/Erwic/Discord/erwicrc --datafolder=${config.xdg.stateHome}/Erwic/Discord https://discord.com/app";
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
        exec = "vieb --config-file=${config.xdg.configHome}/Vieb/Erwic/Element/erwicrc --datafolder=${config.xdg.stateHome}/Erwic/Element https://app.element.io/";
        icon = "${config.xdg.configHome}/Vieb/Erwic/Element/icon.png";
        terminal = false;
        type = "Application";
        categories = ["Network" "Chat" "InstantMessaging"];
      };
      Bitwarden = {
        name = "Bitwarden";
        genericName = "Password Manager";
        exec = "vieb --config-file=${config.xdg.configHome}/Vieb/Erwic/Bitwarden/erwicrc --datafolder=${config.xdg.stateHome}/Erwic/Bitwarden https://vault.bitwarden.com/";
        icon = "${config.xdg.configHome}/Vieb/Erwic/Bitwarden/icon.png";
        terminal = false;
        type = "Application";
        categories = ["Network"];
      };
      Protonmail = {
        name = "Proton Mail";
        genericName = "Electronic Mail Client";
        exec = "vieb --config-file=${config.xdg.configHome}/Vieb/Erwic/Proton_Mail/erwicrc --datafolder=${config.xdg.stateHome}/Erwic/Proton_Mail https://mail.proton.me/";
        icon = "${config.xdg.configHome}/Vieb/Erwic/Proton_Mail/icon.png";
        terminal = false;
        type = "Application";
        categories = ["Network" "Email"];
      };
      YouTube = {
        name = "YouTube";
        genericName = "Video Streaming Platform";
        exec = "vieb --config-file=${config.xdg.configHome}/Vieb/Erwic/YouTube/erwicrc --datafolder=${config.xdg.stateHome}/Erwic/YouTube https://youtube.com/";
        icon = "${config.xdg.configHome}/Vieb/Erwic/YouTube/icon.png";
        terminal = false;
        type = "Application";
        categories = [
          # "Network"
          "AudioVideo"
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
      ### NEW STUFF
      alacritty-toml = {
        text =
          /*
          toml
          */
          ''
            [font]
            size = 12

            [font.bold]
            family = "FiraCode Nerd Font"
            style = "Bold"

            [font.bold_italic]
            family = "FiraCode Nerd Font"
            style = "BoldItalic"

            [font.italic]
            family = "FiraCode Nerd Font"
            style = "MediumItalic"

            [font.normal]
            family = "FiraCode Nerd Font"
            style = "Medium"

            [general]
            import = ["${config.xdg.cacheHome}/wallust/alacritty.toml"]
          '';
        target = "alacritty/alacritty.toml";
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
        text =
          /*
          vim
          */
          ''
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
        text =
          /*
          toml
          */
          ''
            [templates]
            alacritty = { template = "alacritty.toml", target = "${config.xdg.cacheHome}/wallust/alacritty.toml" }
            tty = { template = "tty.sh", target = "${config.xdg.cacheHome}/wallust/tty.sh" }
          '';
        target = "wallust/wallust.toml";
      };
      waybar = {
        source = ./waybar;
      };
    };
  };

  home.file.".vieb".source = ./Vieb;
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

  # Shell variables
  home.sessionVariables =
    config.systemd.user.sessionVariables
    // {
      HISTFILE = config.programs.bash.historyFile;
      HISTCONTROL = builtins.concatStringsSep ":" config.programs.bash.historyControl;
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      LESSHISTFILE = "${config.xdg.stateHome}/less/history";
      MANPAGER = "less -R --use-color -Dd+r -Du+b";
      MANROFFOPT = "-P -c";
      NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
      NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
      INPUTRC = "${config.xdg.configHome}/readline/inputrc";
      RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
      STARSHIP_CONFIG = "${config.xdg.configHome}/starship/starship.toml";
      EDITOR = config.home.sessionVariables.VISUAL;
    };

  # Session variables
  # These are picked up by GDM and KDE Plasma (apparently) but not by SDDM (which loads your shell config) or other DMs
  systemd.user.sessionVariables = {
    XDG_DOCUMENTS_DIR = config.xdg.userDirs.documents;
    XDG_PICTURES_DIR = config.xdg.userDirs.pictures;
    XDG_DOWNLOAD_DIR = config.xdg.userDirs.download;
    XDG_DESKTOP_DIR = config.xdg.userDirs.desktop;
    XDG_VIDEOS_DIR = config.xdg.userDirs.videos;
    XDG_MUSIC_DIR = config.xdg.userDirs.music;
    VIEB_CONFIG_FILE = "${config.xdg.configHome}/Vieb/viebrc";
    VIEB_DATAFOLDER = "${config.xdg.stateHome}/Vieb";
    NVIM_APPNAME = "astronvim";
    VISUAL = "nvim";
    ELECTRON_OZONE_PLATFORM_HINT = "auto"; # enable wayland detection for some electron apps (notably: yes obsidian, yes vieb)
  };

  home.shellAliases = {
    mv = "mv -i";
    clear = "clear -x";
    wget = "wget --hsts-file=${config.xdg.configHome}/wget-hsts";
  };

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
  programs.lazygit = {
    enable = true;
    settings = {
      commandLogSize = 5;
      mainBranches = ["master" "main" "trunk"];
      notARepository = "skip";
    };
  };
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs;
      [
        # lsp
        alejandra
        deadnix
        lua-language-server
        luajitPackages.luacheck
        nil
        nodePackages.vscode-json-languageserver # neoconf
        statix
        stylua
      ]
      ++ [
        # build
        gcc # nvim-treesitter
        git # lazy.nvim
        luarocks # lazy.nvim
        gnumake # jsregexp for LuaSnip
        ripgrep # telescope-fzf-native.nvim
        # xdg-utils?
        # wl-clipboard?
      ];
  };
  programs.starship = {
    enable = true; # adds starship to PATH thus polluitng it
    enableFishIntegration = true;
    enableTransience = true;
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.home-manager.enable = true;
}
