{ config, pkgs, ... }:

{
  # Common system configurations
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Common packages
  environment.systemPackages = with pkgs; [
    git
    kitty
    gh
    google-chrome
    code-cursor
    zed-editor
  ];

  # Common programs
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
  };
}