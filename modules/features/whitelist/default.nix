{ den, ... }:

{
  den.aspects.features.includes = [ den.aspects.whitelist ];

  den.aspects.whitelist.nixos =
    { lib, ... }:
    {
      nixpkgs.config.permittedInsecurePackages = [
        "electron-39.8.10"
      ];

      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          # Nvim Sidekick
          "claude-code"
          "copilot-language-server"
          "github-copilot-cli"

          # Nvidia
          "nvidia-x11"
          "nvidia-settings"
          "nvidia-persistenced"
          "nvidia-kernel-modules"

          # Other
          "discord"
          "dropbox"
          "firefox-bin"
          "firefox-bin-unwrapped"
          "steam"
          "steam-unwrapped"
          "stremio-linux-shell"
          "git-conflict.nvim"
        ];
    };
}
