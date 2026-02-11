{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      # Powerlevel10k instant prompt. Keep this close to the top of zsh init.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      [[ ! -f "${config.xdg.configHome}/zsh/.p10k.zsh" ]] || source "${config.xdg.configHome}/zsh/.p10k.zsh"

      export PATH="$HOME/.tmuxifier/bin:$PATH"
      if command -v tmuxifier >/dev/null 2>&1; then
        eval "$(tmuxifier init -)"
      fi
    '';
    plugins = [{
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }];
    shellAliases = {
      ls = "lsd";
      tmuxfr = "tmuxifier";
    };
  };

  home.file."${config.xdg.configHome}/zsh/.p10k.zsh".source = ./.p10k.zsh;
}
