{ config, pkgs, ... }:

{
  home.homeDirectory = "/home/chronicc";
  home.packages = with pkgs; [
    awscli2
    brave
    docker
    kitty
    minikube
    poetry
    tig
    terraform
  ];
  home.stateVersion = "22.11";
  home.username = "chronicc";

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

  services.dunst = {
    enable = true;
    settings = {
      global = {
        alignment = "left";
        class = "Dunst";
        corner_radius = 10;
        follow = "mouse";
        font = "monospace 10";
        frame_color = "#89B4FA";
        frame_width = 1;
        hide_duplicate_count = true;
        horizontal_padding = 8;
        idle_threshold = 120;
        indicate_hidden = true;
        line_height = 0;
        markup = "full";
        notification_height = 0;
        offset = "10x10";
        origin = "bottom-right";
        padding = 8;
        separator_color = "frame";
        separator_height = 2;
        show_age_threshold = 60;
        show_indicators = true;
        sort = true;
        stack_duplicates = true;
        text_icon_padding = 0;
        timeout = 5;
        title = "Dunst";
        vertical_alignment = "center";
        word_wrap = true;
      };

      urgency_high = {
        background = "#1E1E2ECC";
        foreground = "#CDD6F4";
        frame_color = "#FAB387";
      };

      urgency_low = {
        background = "#1E1E2ECC";
        foreground = "#CDD6F4";
      };

      urgency_normal = {
        background = "#1E1E2ECC";
        foreground = "#CDD6F4";
      };
    };
  };
}
