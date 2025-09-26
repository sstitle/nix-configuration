{ pkgs, config, ... }:

{
  # Common system configurations
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # This setting is necessary for Nickel-lang organist
  nix.settings.allow-import-from-derivation = true;

  # Add ccache directory to sandbox paths
  nix.settings.extra-sandbox-paths = [ config.programs.ccache.cacheDir ];

  # Add ccache overlay
  nixpkgs.overlays = [
    (self: super: {
      ccacheWrapper = super.ccacheWrapper.override {
        extraConfig = ''
          export CCACHE_COMPRESS=1
          export CCACHE_DIR="${config.programs.ccache.cacheDir}"
          export CCACHE_UMASK=007
          export CCACHE_SLOPPINESS=random_seed
          if [ ! -d "$CCACHE_DIR" ]; then
            echo "====="
            echo "Directory '$CCACHE_DIR' does not exist"
            echo "Please create it with:"
            echo "  sudo mkdir -m0770 '$CCACHE_DIR'"
            echo "  sudo chown root:nixbld '$CCACHE_DIR'"
            echo "====="
            exit 1
          fi
          if [ ! -w "$CCACHE_DIR" ]; then
            echo "====="
            echo "Directory '$CCACHE_DIR' is not accessible for user $(whoami)"
            echo "Please verify its access permissions"
            echo "====="
            exit 1
          fi
        '';
      };
    })
  ];

  # Common packages
  environment.systemPackages = with pkgs; [
    git
    gh
    atuin
    eza
    bat
    lazygit
    lazydocker
    zoxide

    neovim
    nh
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
      export CCACHE_DIR=/var/cache/ccache
    '';
  };
  users.defaultUserShell = pkgs.zsh;

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

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
  };

  programs.nh = {
    enable = true;
    flake = "/home/samtitle/personal/nix-configuration";
  };

  # Enable ccache for faster compilation
  programs.ccache = {
    enable = true;
    cacheDir = "/var/cache/ccache";
    # You can specify which packages should use ccache here
    # packageNames = [ "your-package-name" ];
  };
}
