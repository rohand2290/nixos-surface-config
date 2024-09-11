{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim = {
    	url = "github:nix-community/nixvim";
	# inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, stylix, ... }@inputs: {
    nixosConfigurations.surface = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/surface/configuration.nix
	stylix.nixosModules.stylix
	home-manager.nixosModules.home-manager
	{
	   home-manager.useGlobalPkgs = true;
	   home-manager.useUserPackages = true;
	   home-manager.users.rohand = { ... }: {
	   	imports = [
			nixvim.homeManagerModules.nixvim
			./hosts/surface/home.nix
		];
	   };
	}
        # inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.xps = nixpkgs.lib.nixosSystem {
    	system = "x86_64-linux";
	specialArgs = {inherit inputs;};
	modules = [
		./hosts/xps/configuration.nix
		stylix.nixosModules.stylix
		home-manager.nixosModules.home-manager
		{
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.users.rohand = {... }: {
				imports = [
					nixvim.homeManagerModules.nixvim
					./hosts/xps/home.nix
				];
			};
		}
	];
    };
  };
}
