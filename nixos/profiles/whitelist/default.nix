{ lib, ... }:

{
  nixpkgs.config.permittedInsecurePackages = [
    # Stremio
    "qtwebengine-5.15.19"
  ];

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
      "stremio-server"
      "stremio-shell"
    ];
}
