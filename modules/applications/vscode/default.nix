{ config, lib, pkgs, ... }:

let
in {
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
        {
          name = "yuck";
          publisher = "eww-yuck";
          version = "0.0.3";
          sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
        }
      ];
    mutableExtensionsDir = false;
  };
}
