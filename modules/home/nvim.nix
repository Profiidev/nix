{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    lua-language-server
    luarocks
    lua
    tree-sitter
    asm-lsp
    basedpyright
    cmake-language-server
    csharp-ls
    docker-compose-language-service
    docker-language-server
    eslint
    glsl_analyzer
    gopls
    helm-ls
    vscode-langservers-extracted
    jsonnet-language-server
    just-lsp
    nginx-language-server
    nixd
    rust-analyzer
    svelte-language-server
    tailwindcss-language-server
    terraform-ls
    typescript-language-server
    wgsl-analyzer
    yaml-language-server
    nixfmt
    gh-actions-language-server
  ];
}
