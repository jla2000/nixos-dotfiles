{ pkgs, lib, config, ... }:
let
  tomlFormat = pkgs.formats.toml { };
in
{
  options.helix.cpp.formatter = lib.mkOption {
    type = tomlFormat.type;
    default = {
      command = "clang-format";
      args = [ "-style=file" ];
    };
  };

  config = {
    programs.helix = {
      enable = true;
      package = pkgs.helix-unstable;
      extraPackages = with pkgs; [
        python3Packages.python-lsp-server
        clang-tools_16
        cmake-language-server
      ];
      settings = {
        theme = "gruvbox";
        editor = {
          mouse = true;
          line-number = "relative";
          true-color = true;
          file-picker.hidden = false;
          lsp = {
            display-messages = true;
            display-inlay-hints = false;
          };
          indent-guides.render = true;
        };
        keys.insert = {
          j.k = "normal_mode";
        };
        keys.normal = {
          C-g = [ ":new" ":insert-output ${pkgs.lazygit}/bin/lazygit" ":buffer-close!" ":redraw" ];
        };
      };
      languages.language = [
        {
          name = "cpp";
          auto-format = true;
          formatter = config.helix.cpp.formatter;
        }
        {
          name = "cmake";
          auto-format = true;
          formatter = {
            command = "${pkgs.cmake-format}/bin/cmake-format";
            args = [ "-" ];
          };
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
        }
        {
          name = "python";
          auto-format = true;
          formatter = {
            command = "${pkgs.black}/bin/black";
            args = [ "-" "--quiet" ];
          };
        }
      ];
    };

    home.sessionVariables.EDITOR = "hx";
  };
}
