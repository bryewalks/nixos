{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    plugins = [
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.dracula
      pkgs.tmuxPlugins."vim-tmux-navigator"
    ];
    extraConfig = ''
      unbind r
      bind r source-file ~/.tmux.conf

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
