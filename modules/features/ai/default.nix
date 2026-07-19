{ den, inputs, ... }:

{
  flake-file.inputs.mcp-servers-nix = {
    url = "github:natsukium/mcp-servers-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.features.includes = [ den.aspects.ai ];

  den.aspects.ai = {
    nixos = {
      mySystem.allowedUnfree = [ "claude-code" ];
    };

    provides.to-users.homeManager = {
      imports = [ inputs.mcp-servers-nix.homeManagerModules.default ];

      mcp-servers.programs.nixos.enable = true;

      programs.mcp = {
        enable = true;
        servers.context7 = {
          url = "https://mcp.context7.com/mcp";
        };
      };

      programs.claude-code = {
        enable = true;
        enableMcpIntegration = true;
      };
    };
  };
}
