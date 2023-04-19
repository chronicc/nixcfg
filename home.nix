{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Zafiro-icons-Dark";
      package = pkgs.zafiro-icons;
    };
    font = {
      name = "DejaVu Sans";
      package = pkgs.dejavu_fonts;
    };
  };

  home = {
    file = {
      ".config/hypr" = {
        source = ./dotfiles/hypr;
        recursive = true;
      };
    };
    homeDirectory = "/home/chronicc";
    packages = with pkgs; [
      awscli2
      brave
      docker
      minikube
      poetry
      tig
      terraform
    ];
    pointerCursor = { 
      gtk.enable = true;
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };
    stateVersion = "22.11";
    username = "chronicc";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [
      "erasedups"
      "ignoredups"
    ];
    logoutExtra = ''
      clear
    '';
    shellAliases = {
      ".." = "cd ..";
      ll = "ls -lah --group-directories-first";
      myip = "curl https://ipinfo.io/ip";
      nossh = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
    };
    shellOptions = [
      "histappend"
    ];
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = false;
    enableNushellIntegration = false;
    enableZshIntegration = false;
    nix-direnv.enable = true;
    stdlib = ''
      layout_poetry() {
          PYPROJECT_TOML="''${PYPROJECT_TOML:-pyproject.toml}"
          if [[ ! -f "$PYPROJECT_TOML" ]]; then
              log_status "No pyproject.toml found. Executing \`poetry init\` to create a \`$PYPROJECT_TOML\` first."
              poetry init
          fi

          VIRTUAL_ENV=$(poetry show -v 2>/dev/null | grep -oE '/home/.*/.cache/pypoetry/virtualenvs/.*' ; true)

          if [[ -z $VIRTUAL_ENV || ! -d $VIRTUAL_ENV ]]; then
              log_status "No virtual environment exists. Executing \`poetry install\` to create one."    
              poetry install
              VIRTUAL_ENV=$(poetry env info --path)
          fi

          PATH_add "$VIRTUAL_ENV/bin"
          export POETRY_ACTIVE=1
          export VIRTUAL_ENV
      }
    '';
  };

  programs.jq = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "Source Code Pro";
      size = 16;
    };
    keybindings = {
      "ctrl+shift+up" = "change_font_size all +2.0";
      "ctrl+shift+down" = "change_font_size all -2.0";
      "ctrl+shift+backspace" = "change_font_size all 0";
    };
    settings = {
      background_opacity = "0.9";
      enable_audio_bell = "no";
      placement_stragegy = "top-left";
      scrollback_lines = "5000";
      visual_bell_duration = "0.0";
      window_border_width = "0";
      window_margin_width = "4";
      window_padding_width = "0";
    };
    theme = "Gruvbox Dark";
  };

  programs.neovim = {
    coc = {
      enable = true;
    };
    defaultEditor = true;
    enable = true;
    extraConfig = ''
      " Tab size
      set expandtab
      set hlsearch
      set preserveindent
      set shiftwidth=2
      set softtabstop=0
      set tabstop=2

      " Colorscheme
      syntax enable

      " Undo
      set undodir=$HOME/.vim/undo
      set undofile
      set undolevels=1000
    '';
    viAlias = true;
    vimAlias = true;
  };

  programs.readline = {
    bindings = {
      "\\e[A" = "history-search-backward";
      "\\e[B" = "history-search-forward";
    };
    enable = true;
    variables = {
      completion-ignore-case = true;
      expand-tilde = true;
      history-preserve-point = true;
      show-all-if-ambiguous = true;
    };
  };

  home.file.".config/waybar" = {
    source = ./dotfiles/waybar;
    recursive = true;
  };
  programs.waybar = {
    enable = true;
  };
}
