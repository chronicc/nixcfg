{ config, pkgs, ... }:

let
  user_home_dir = "/home/chronicc";
in {
  gtk = {
    enable = true;
    # theme = {
    #   # name = "Canta-dark-compact";
    #   # package = pkgs.canta-theme;
    #   # name = "Dracula";
    #   # package = pkgs.dracula-theme;
    # };
    iconTheme = {
      name = "Zafiro-icons-Dark";
      package = pkgs.zafiro-icons;
    };
    font = {
      name = "DejaVu Sans";
      package = pkgs.dejavu_fonts;
    };
  };

  home.file = {
    ".minikube/config/config.json".source = ./minikube_config.json;
    ".ssh/config".source = ./ssh_config;
  };
  home = {
    homeDirectory = user_home_dir;
    packages = with pkgs; [
      (vagrant.override {
        withLibvirt = false; # disable installation of outdated libvirt plugin
      }) # Virtual machine manager
      ardour # Digital Audio Workstation
      aws-nuke # AWS account cleaner
      awscli2 # AWS CLI
      cinnamon.nemo # File manager
      docker # Container runtime
      fff # File manager
      font-manager # Font manager
      gimp # Image manipulation
      git-remote-codecommit # AWS CodeCommit git remote helper
      gnome.simple-scan # Scanner GUI
      gnumake # Make
      helmfile # Helmfile
      kubectl # Kubernetes CLI
      kubernetes-helm # Helm
      minikube # Kubernetes cluster
      neofetch # System info
      networkmanagerapplet # Network manager GUI
      nextcloud-client # Nextcloud client
      nixos-generators # NixOS image generators
      nmap # Network scanner
      nodejs # Node.js
      openlens # Kubernetes cluster manager
      pamixer # PulseAudio mixer GUI
      pandoc # Document Converter
      pavucontrol # PulseAudio mixer GUI
      poetry # Python package manager
      ranger # File manager
      signal-desktop # Signal messenger
      skaffold # Kubernetes dev tool
      slack # Slack messenger
      spotify # Spotify client
      tealdeer # tldr client
      teamspeak_client # Teamspeak client
      terraform # Terraform
      tig # Git CLI
      velero # Kubernetes backup tool
      wl-clipboard # Clipboard manager
      yamllint # YAML linter
      yq-go # YAML parser
    ];
    pointerCursor = {
      gtk.enable = true;
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 24;
    };
    stateVersion = "22.11";
    username = "chronicc";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "erasedups" "ignoredups" ];
    logoutExtra = ''
      clear
    '';
    shellAliases = {
      ".." = "cd ..";
      ll = "ls -lah --group-directories-first";
      myip = "curl https://ipinfo.io/ip";
      nossh = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
    };
    shellOptions = [ "histappend" ];
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

  programs.jq = { enable = true; };

  programs.neovim = {
    coc = { enable = false; };
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
    plugins = with pkgs.vimPlugins; [
      vim-polyglot
    ];
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

  xdg.configFile."wallpaper.png".source = ./wallpaper.png;
}
