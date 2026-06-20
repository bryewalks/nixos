{ ... }:

{
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
}
