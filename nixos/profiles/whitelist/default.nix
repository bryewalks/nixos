{ lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      # Nvim Sidekick
      "claude-code"
      "copilot-language-server"
      "github-copilot-cli"

      # Other
      "discord"
      "dropbox"
      "firefox-bin"
      "firefox-bin-unwrapped"
      "steam"
      "steam-unwrapped"
    ];
}
