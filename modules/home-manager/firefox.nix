{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles = {
      default = {
        settings = {
          "layout.css.devPixelsPerPx" = "2.3";
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          #vimium
          surfingkeys
        ];
        bookmarks = [
          {
            name = "Home-Manager Options";
            url = "https://nix-community.github.io/home-manager/options.html";
          }
        ];
      };
    };
  };
}
