{ den, inputs, ... }:

{
  flake-file.inputs.mcp-servers-nix = {
    url = "github:natsukium/mcp-servers-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.workstation.includes = [ den.aspects.ai ];

  den.aspects.ai = {
    nixos = {
      unfree.packages = [ "claude-code" ];
    };

    provides.to-users.homeManager = {
      imports = [ inputs.mcp-servers-nix.homeManagerModules.default ];

      # BUG: Disabled: mcp-nixos depends on fastmcp -> fastmcp-slim, which
      # nixpkgs currently marks broken
      mcp-servers.programs.nixos.enable = false;

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
