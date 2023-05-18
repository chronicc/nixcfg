{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Canta-dark-compact";
      package = pkgs.canta-theme;
      # name = "Dracula";
      # package = pkgs.dracula-theme;
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
      aws-nuke
      bemenu
      brave
      cinnamon.nemo
      docker
      fff
      font-manager
      git-remote-codecommit
      gnumake
      helmfile
      kubectl
      kubernetes-helm
      minikube
      neofetch
      networkmanagerapplet
      nextcloud-client
      nixfmt # vscode
      nodejs
      openlens
      pamixer
      pavucontrol
      poetry
      slack
      spotify
      tealdeer
      tig
      terraform
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

  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    extensions = with pkgs.vscode-extensions;
      [
        _4ops.terraform
        asciidoctor.asciidoctor-vscode
        bbenoist.nix
        bungcip.better-toml
        # dhoeric.ansible-vault
        # diego-vieira.codeception-snippets
        # joshuapoehls.json-escaper
        # marioqueiros.camelcase
        mikestead.dotenv
        # redhat.vscode-commons
        wholroyd.jinja
        # zardoy.fix-all-json
        # bazelbuild.vscode-bazel
        # aykutsarac.jsoncrack-vscode
        davidanson.vscode-markdownlint
        ms-dotnettools.csharp
        ritwickdey.liveserver
        # tim-koehler.helm-intellisense
        golang.go
        oderwat.indent-rainbow
        redhat.vscode-yaml
        # shaimendel.kubernetesapply
        ms-kubernetes-tools.vscode-kubernetes-tools
        # mitchdenny.ecdc
        # doggy8088.k8s-snippets
        ms-toolsai.jupyter-keymap
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
        ms-toolsai.jupyter-renderers
        eamodio.gitlens
        bierner.markdown-mermaid
        ms-toolsai.jupyter
        # pomdtr.excalidraw-editor
        ms-azuretools.vscode-docker
        # redhat.ansible
        timonwong.shellcheck
        ms-python.python
        ms-vsliveshare.vsliveshare
        ms-python.vscode-pylance
        redhat.vscode-xml
        github.copilot
        ms-vscode.makefile-tools
        yzhang.markdown-all-in-one
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # {
        #   name = "nixfmt-vscode";
        #   publisher = "brettm12345";
        #   version = "0.0.1";
        #   sha256 = "sha256-8yglQDUc0CXG2EMi2/HXDJsxmXJ4YHvjNjTMnQwrgx8=";
        # },
        {
          name = "font-preview";
          publisher = "ctcuff";
          version = "2.2.1";
          sha256 = "sha256-n89jwcTnuxMhs21wG9F6a8bYeNDQGx2yptYCcUH9R+o=";
        }
      ];
    mutableExtensionsDir = false;
  };
}
