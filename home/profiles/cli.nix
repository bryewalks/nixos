{ pkgs, ... }:

{
  # Programs
  programs.zsh.enable = true;

  programs.git = {
    enable = true;
    settings.user.name = "bryewalks";
    settings.user.email = "bryewalks@gmail.com";
    settings.safe.directory = [ "/etc/nixos" ];
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
        extraOptions = {
          AddKeysToAgent = "yes";
        };
      };
    };
  };

  # Services
  services.ssh-agent.enable = true;
  
  services.udiskie = {
    enable = true;
    automount = true;
    settings = {
      program_options = {
        file_manager = "dolphin";
      };
    };
  };

  # Packages
  home.packages = with pkgs; [
    ripgrep
    fd
  ];
}
