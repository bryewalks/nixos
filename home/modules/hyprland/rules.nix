{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    workspace_rule = [
      { workspace = "special:browser"; layout = "scrolling"; }
    ];

    window_rule = [
      {
        name = "suppress-maximize-events";
        match.class = ".*";
        suppress_event = "maximize";
      }
      {
        name = "fix-xwayland-drags";
        match = {
          class = "^$";
          title = "^$";
          xwayland = true;
          float = true;
          fullscreen = false;
          pin = false;
        };
        no_focus = true;
      }
      # Remove to keep zen-beta confined to special:browser workspace
      {
        name = "zen-beta-current-workspace";
        match.class = "^zen-beta$";
        workspace = "current";
      }
      {
        name = "thunar-current-workspace";
        match.class = "^thunar$";
        workspace = "current";
      }
      {
        name = "launchers-workspace";
        match.class = "^(steam|com.valvesoftware.Steam|itch|io.itch.itch|heroic|com.heroicgameslauncher.hgl|r2modman)$";
        workspace = "special:steam silent";
      }
      {
        name = "valent-workspace";
        match.class = "^valent$";
        workspace = "special:texts silent";
      }
      {
        name = "movies-workspace";
        match.class = "^com\\.stremio\\.stremio$";
        workspace = "special:movies silent";
      }
    ];
  };
}
