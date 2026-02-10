{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      sensible
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-empty-plugins false
          set -g @dracula-weather-hide-errors true
        '';
      }
    ];
    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind-key C-o popup -E -d "#{pane_current_path}" -w 90% -h 90% "opencode"
      bind-key C-c split-window -h -c "#{pane_current_path}" "opencode"

      set-option -g status-position bottom
      set -g allow-passthrough on
      set -g visual-activity off
    '';
  };
}
