{
  imports = [
    ./monitors.nix
    ./colors.nix
    ./hyprland.nix
    ./firefox.nix
    ./alacritty.nix
    ./fish.nix
    ./eww
  ];

  monitors = [
    {
      name = "eDP-2";
      mode = "2560x1600@120";
      position = "auto";
      scale = 1.2;
    }
  ];

  home = {
    username = "jan";
    homeDirectory = "/home/jan";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
