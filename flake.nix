{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { nixpkgs }: {
    nixosConfigurations.sams-shadow = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/common
        ./hosts/sams-shadow/configuration.nix
      ];
    };
  };
}
