{ pkgs, ... }:

{
  # Packages
  home.packages = with pkgs; [ ripgrep fd fastfetch firefox codex ];

  # Programs
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = "source ~/.p10k.zsh";
    plugins = [{
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }];
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
        extraOptions = { AddKeysToAgent = "yes"; };
      };
    };
  };

  # Services
  services.ssh-agent.enable = true;

  services.udiskie = {
    enable = true;
    automount = true;
  };
}
