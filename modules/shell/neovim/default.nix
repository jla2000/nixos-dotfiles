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
      nvim-treesitter-textobjects
      nvim-treesitter-context
      tokyonight-nvim
      flash-nvim
      nvim-lspconfig
      indent-blankline-nvim
      cmake-tools-nvim
      nvim-web-devicons
      nvim-autopairs
      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      luasnip
      conform-nvim
      marks-nvim
      better-escape-nvim
      gitsigns-nvim
      persistence-nvim
      yanky-nvim
      noice-nvim
      nui-nvim
      trouble-nvim
      nvim-surround
      lazydev-nvim
      windline-nvim
      dressing-nvim
      headlines-nvim
    ];
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      nixd
      nixpkgs-fmt
    ];
  };

  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
  xdg.configFile."nvim/lua".source = ./nvim/lua;
  xdg.configFile."nvim/parser".source = "${treesitter-parsers}/parser";

  home.sessionVariables.EDITOR = "nvim";
}
