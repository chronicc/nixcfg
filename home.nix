{ config, pkgs, ... }:

{
  home.homeDirectory = "/home/chronicc";
  home.packages = with pkgs; [
    bottom
    git
    tig
  ];
  home.stateVersion = "22.11";
  home.username = "chronicc";

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
}
