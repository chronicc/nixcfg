{ config, pkgs, ... }:

let
  user_home_dir = "/home/chronicc";
  user_repository_dir = "${user_home_dir}/git/chronicc/flakes";
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

  home = {
    homeDirectory = user_home_dir;
    packages = with pkgs; [
      ardour
      awscli2
      aws-nuke
      bemenu
      brave
      cinnamon.nemo
      docker
      fff
      font-manager
      git-remote-codecommit
      gnome.simple-scan
      gnumake
      helmfile
      kubectl
      kubernetes-helm
      minikube
      neofetch
      networkmanagerapplet
      nextcloud-client
      nixfmt # vscode
      nixos-generators
      nodejs
      openlens
      pamixer
      pavucontrol
      poetry
      ranger
      signal-desktop
      skaffold
      slack
      spotify
      tealdeer
      teamspeak_client
      tig
      terraform
      velero
      wl-clipboard
      yamllint
      yq-go
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
