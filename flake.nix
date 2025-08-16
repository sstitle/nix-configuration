{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    nixosConfigurations.sams-shadow = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/common
        ./hosts/sams-shadow/configuration.nix
      ];
    };
  };
}
