{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    lua-language-server
    luarocks
    lua
    tree-sitter
  ];
}
