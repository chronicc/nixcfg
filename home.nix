{ config, pkgs, ... }:

{
  home.homeDirectory = "/home/chronicc";
  home.packages = with pkgs; [
    tig
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
}
