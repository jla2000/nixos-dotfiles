{ pkgs, config, ... }: {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      rust-analyzer
      lua-language-server
      stylua
      nil
      taplo
      nodePackages.prettier
      marksman
      nixfmt
      shfmt
    ];
    defaultEditor = true;
  };

  home.shellAliases = { v = "nvim"; };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.sessionVariables.FLAKE}/modules/home/neovim/nvim";
}
