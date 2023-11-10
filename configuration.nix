# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, home-manager, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./asus-rog.nix
  ];
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  networking.hostName = "zephyrus";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status
      i3lock
      networkmanagerapplet
      dunst
    ];
  };

  programs.fish.enable = true;

  users.users.jan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    lazygit
    kitty
    firefox
    starship
    gcc
    cmake
    gnumake
    nodejs
    cargo
    rustc
    unzip
    brightnessctl
    htop
    killall
    spotify
    pciutils
    discord
    libreoffice-fresh
    ventoy-full
    thunderbird
    meld
    starship
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    fira
    font-awesome
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

