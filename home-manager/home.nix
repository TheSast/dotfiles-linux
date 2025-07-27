{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: let
  flakeLoc = "${config.xdg.configHome}/etc";
  symlinkDirectly = p: config.lib.file.mkOutOfStoreSymlink ("${flakeLoc}/home-manager/" + p);
in {
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
      builtins.elem (lib.getName pkg) [
        "obsidian"
      ];
  };
  home.packages = with pkgs; [
    alacritty
    babelfish
    bat
    batsignal
    brightnessctl
    broot
    btop
    cliphist
    du-dust
    erdtree
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
    pkgs-unstable.nh
    onefetch
    ouch
    playerctl
    ripgrep # prog
    rofi-wayland # prog
    swayimg
    swww
    tmux # prog
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
        source = symlinkDirectly "astronvim";
      };
      bat = {
        target = "bat/config";
        text = "--theme=ansi";
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
        source = symlinkDirectly "scripts";
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
    dataFile = {
      "current-user-packages".text = let
        packages = builtins.map (p: "${p.name}") config.home.packages;
        sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
        formatted = builtins.concatStringsSep "\n" sortedUnique;
      in
        formatted;
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
    nh = "FLAKE=${flakeLoc} command nh";
  };

  programs.atuin = {
    enable = true;
    settings = {
      dialect = "uk";
      update_check = false;
      auto_sync = false;
      sync_address = "";
      workspaces = true;
      enter_accept = false;
      keymap_mode = "vim-insert";
      keymap_cursor = {
        emacs = "blink-block";
        vim_insert = "blink-block";
        vim_normal = "steady-block";
      };
    };
    flags = [
      "--disable-up-arrow"
    ];
  };
  programs.bash = {
    enable = false; # on will create ~/.bashrc
    historyFile = "${config.xdg.stateHome}/bash/history";
    historyControl = ["erasedups"];
  };
  programs.command-not-found.enable = false;
  programs.eza = {
    enable = true;
    git = true;
    icons = true;
  };
  programs.fish = {
    enable = true;
    package =
      pkgs
      .fish
      .overrideAttrs (oldAttrs: {
        desktopItem = null;
        postInstall =
          oldAttrs.postInstall
          or ""
          + ''
            rm -f $out/share/applications/fish.desktop
          '';
      });
    shellInit = ''
      set fish_greeting
    '';
    functions = {
      boy =
        /*
        fish
        */
        ''
          if test $argv[1] = --help
              echo boy - a prettier way to read program help pages
              return
          end
          $argv --help 2>&1 | bat --plain --language=help
        '';
      cd =
        /*
        fish
        */
        ''
          builtin cd $argv || return
          set -l current_repository (git rev-parse --show-toplevel 2> /dev/null)
          if string length -q -- $current_repository && not string match -q -- $current_repository $__last_repository
            functions -c fish_prompt fish_prompt_bak
            functions -e fish_prompt
            function fish_prompt
              functions -e fish_prompt
              functions -c fish_prompt_bak fish_prompt
              functions -e fish_prompt_bak
              ! ${lib.getExe pkgs.onefetch} --include-hidden --no-bots 2> /dev/null
              set -g TRANSIENT $status
              fish_prompt
              set -e TRANSIENT
            end
            set -gx __last_repository $current_repository
          end
        '';
      # IDEA:
      # from https://github.com/oh-my-fish/plugin-cd
      # cd .../foo           # <=> cd ../../foo
      # cd ...               # <=> cd ../..
      # cd .../foo/.../bar   # <=> cd ../../foo/../../bar
      # pwd                  # ~/a
      # cd ~/b               # ~/b    ( dirstack: a )
      # cd ~/c               # ~/c    ( dirstack: b a )
      # cd ~/d               # ~/d    ( dirstack: c b a )
      # cd -2                # ~/b    ( dirstack: d c a )
      # cd +1                # ~/c    ( dirstack: b d a )
      # cd +0                # ~/a    ( dirstack: c b d )
      # cd -0                # ~/a    ( dirstack: c b d )
      nix-build = ''echo "Error: 'nix-build' is deprecated. Please use 'nix build' instead."'';
      nix-channel = ''echo "Error: 'nix-channel' is deprecated. Please use flakes instead."'';
      nix-collect-garbage = ''echo "Error: 'nix-collect-garbage' is deprecated. Please use 'nix gc' instead."'';
      nix-daemon = ''echo "Error: 'nix-daemon' is deprecated. Please use 'nix daemon' instead."'';
      nix-env = ''echo "Error: 'nix-env' is deprecated. Please use 'nix profile' instead."'';
      nix-hash = ''echo "Error: 'nix-hash' is deprecated. Please use 'nix hash' instead."'';
      nix-shell = ''echo "Error: 'nix-shell' is deprecated. Please use 'nix develop' instead."'';
      home-manager =
        /*
        fish
        */
        ''
          if contains -- "$argv[1]" switch build
              echo "Error: 'home-manager $argv[1]' is deprecated. Please use 'nh home' instead."
          end
          if test "$argv[1]" = uninstall
              echo "Error: 'home-manager' is installed decleratively."
          end
          command home-manager $argv
        '';
      nix =
        /*
        fish
        */
        ''
          if test "$argv[1]" = profile
              echo "Error: 'nix profile' is not declarative. Aborting."
              return 1
          end
          if contains -- "$argv[1]" build shell develop
              if contains -- "$argv[1]" shell develop && not string match -q -- --command $argv && not string match -q -- -c $argv && not string match -q -- --help $argv
                  command ${lib.getExe pkgs.nix-output-monitor} $argv --command $SHELL
                  return $status
              else
                  command ${lib.getExe pkgs.nix-output-monitor} $argv
                  return $status
              end
          end
          if test "$argv[1]" = gc
            command nix profile wipe-history $argv[2..]
            set -l retv $status
            if test $retv -eq 0 && not string match -q -- --help $argv
              command nix store gc
              return $status
            end
            return $retv
          end
          command nix $argv
        '';
      _multicd =
        /*
        fish
        */
        ''
          if string match -q -r -- / $argv[1]
              echo (string repeat -n (math (string length -- (string replace -a / "" $argv[1])) - 1) ../)
          else
              echo (string join "" (string repeat -n (math (string length -- $argv[1]) - 2) ../) ..)
          end
        '';
      _multicd_expr =
        /*
        fish
        */
        ''
          set acc
          for str in (string split -- "/" $argv)
              if string match -q --regex "\.{3,}\/*" -- $str
                  set acc (string join "/" $acc (_multicd $str))
              else
                  set acc (string join "/" $acc $str)
              end
          end
          echo $acc
        '';
      starship_transient_prompt_func =
        /*
        fish
        */
        ''
          echo -e -n "\n- \n"
        '';
      fish_hybrid_key_bindings =
        /*
        fish
        */
        ''
          # would use fish_user_key_bindings but starship / default prompt only displays mode with fish_vi_key_bindings or fish_hybrid_key_bindings
          bind --erase --all --preset

          if test "$fish_key_bindings" != fish_hybrid_key_bindings
              set -q fish_key_bindings
              or set -g fish_key_bindings
              set fish_key_bindings fish_hybrid_key_bindings # trigger handler
              return
          end

          for mode in insert replace
              fish_default_key_bindings -M $mode
          end
          fish_vi_key_bindings --no-erase

          for mode in default visual insert replace
            bind -e --preset -M $mode -k enter
            bind -e --preset -M $mode \cl
            bind -e --preset -M $mode \cy
            bind -e --preset -M $mode \e.
            bind -e --preset -M $mode \ee
            bind -e --preset -M $mode \el
            bind -e --preset -M $mode \ev
            bind -e --preset -M $mode \ew
            bind -e --preset -M $mode \ey
            bind -e --preset -M $mode \n
            bind -e --preset -M $mode \r
          end
          for mode in default visual
            bind --preset -M $mode -k enter ""
            bind --preset -M $mode \n ""
            bind --preset -M $mode \r ""
            bind -e --preset -M $mode -k backspace
            bind -e --preset -M $mode \cd
            bind -e --preset -M $mode \cu
            bind -e --preset -M $mode \cw
            bind -e --preset -M $mode \t
            bind -e --preset -M $mode \x7F
          end
          bind -e --user -M default \r # remove transient_execute by starship
          bind --preset -M default \e 'if commandline -P; commandline -f cancel; else; edit_command_buffer; end'
          for mode in insert replace
            bind --preset -M $mode -m default \cc cancel repaint-mode
            bind --preset -M $mode -m default jk cancel repaint-mode
            bind --preset -M $mode -m default kj cancel repaint-mode
            bind --preset -M $mode \cd delete-char
            bind --preset -M $mode \cd delete-char
            bind --preset -M $mode \n ""
          end
          bind --preset -M replace -k enter insert-line-over
          bind --preset -M replace \r insert-line-over
          # prevent escape sequences from triggering the escape key bind
          for mode in default visual insert replace
            for map in a b c d e f g h i j k l m n o p q r s t u v x y z 0 1 2 3 4 5 6 7 8 9 . \\ \| '\x20' '\x7F' '\r' '\t'
              if not bind --preset -M $mode (string join "" \e $map) &> /dev/null
                bind --preset -M $mode (string join "" \e $map) self-insert
              end
            end
            for map in \'"-k "(bind -K)\'
              if not bind --preset -M $mode $map &> /dev/null
                bind --preset -M $mode $map self-insert
              end
            end
          end
        '';
    };
    interactiveShellInit =
      /*
      fish
      */
      ''
        fish_hybrid_key_bindings
        set -g fish_sequence_key_delay_ms 150
        abbr --add dotdotdot --regex '^\.{3,}\/*$' --function _multicd # can't go in fish.shellAbbrs because of `--regex` # TODO: add support for ls, eza, cd, etc
        set fish_cursor_default block
        set fish_cursor_visual block
        set fish_cursor_insert line
        set fish_cursor_replace_one underscore
        set fish_cursor_replace underscore
        set fish_cursor_external line blink
        functions -e la
        functions -e ll
        functions -e ls
        sh ${config.xdg.cacheHome}/wallust/tty.sh
        eval (${lib.getExe pkgs.starship} init fish)
        enable_transience
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
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.home-manager.enable = true;
}
