{ pkgs, ... }:
let
  treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitter.dependencies;
  };
in
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lz-n
      telescope-nvim
      telescope-fzf-native-nvim
      oil-nvim
      nvim-treesitter
      tokyonight-nvim
      flash-nvim
      nvim-lspconfig
      indent-blankline-nvim
      cmake-tools-nvim
      nvim-web-devicons
      nvim-autopairs
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      conform-nvim
    ];
    extraPackages = with pkgs; [
      lua-language-server
      stylua
    ];
  };

  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  xdg.configFile."nvim/parser".source = "${treesitter-parsers}/parser";
}