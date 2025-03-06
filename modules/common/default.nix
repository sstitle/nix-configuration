{ pkgs, ... }:

{
  # Common system configurations
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Common packages
  environment.systemPackages = with pkgs; [
    git
    gh
    atuin
    eza
    bat
    lazygit

    nixd
    nixfmt-rfc-style

    ghostty
    code-cursor
    zed-editor

    google-chrome
    spotify
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Common programs
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      push = {
        autoSetupRemote = true;
      };
    };
  };

  # enable and configure zsh, set as default shell
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellInit = ''
      eval "$(atuin init zsh)"
    '';
  };
  users.defaultUserShell = pkgs.zsh;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
  };

  services.atuin = {
    enable = true;
  };


  programs.nix-ld = {
    enable = true;
    # libraries = with pkgs; [
    #   # Add any missing dynamic libraries for unpackaged
    #   # programs here, NOT in environment.systemPackages
    # ];
  };
}
