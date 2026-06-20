{ ... }:

{
  mcp-servers.programs.nixos.enable = true;

  programs.mcp.enable = true;

  programs.claude-code = {
    enable = true;
    enableMcpIntegration = true;
  };
}
