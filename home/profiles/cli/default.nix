{ pkgs, ... }:

{
  # Programs
  programs.zsh.enable = true;
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "powerlevel10k/powerlevel10k";
      plugins = [ "git" "thefuck" "zsh-autosuggestions" "zsh-syntax-highlighting" ];
    };
  };

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
  };

  # Packages
  home.packages = with pkgs; [
    ripgrep
    fd
  ];
}
