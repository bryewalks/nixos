{ lib, hyprlandLib, ... }:
let
  inherit (hyprlandLib) startupHook;
  gameTitles = [
    "Slay the Spire 2"
  ];
  gameTitleRegex = "^(${lib.concatStringsSep "|" gameTitles})$";
in
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      { output = "DP-1"; mode = "2560x1440@180"; position = "0x0";    scale = 1; }
      { output = "DP-2"; mode = "2560x1440@180"; position = "2560x0"; scale = 1; }
    ];

    workspace_rule = [
      { workspace = "1"; monitor = "DP-1"; default = true; }
      { workspace = "3"; monitor = "DP-1"; default = true; layout = "scrolling"; }
      { workspace = "2"; monitor = "DP-2"; default = true; }
      { workspace = "4"; monitor = "DP-2"; default = true; layout = "scrolling"; }
    ];

    window_rule = [
      {
        name = "games-workspace";
        match.class = "^(steam_app_.*|cs2|lutris|HytaleClient|bottles|itch|minigalaxy|gamescope|playnite.*|chiaki|moonlight|.*[Ww]ine.*|com.moonlight_stream.Moonlight|com.hypixel.HytaleLauncher)$";
        workspace = "1 silent";
      }
      {
        name = "games-workspace-title";
        match.class = gameTitleRegex;
        workspace = "1 silent";
      }
      {
        name = "games-workspace-tag";
        match.xdg_tag = "^(proton-game)$";
        workspace = "1 silent";
      }
      {
        name = "discord-workspace";
        match.class = "^(discord|com.discordapp.Discord|vesktop|dev.vencord.Vesktop)$";
        workspace = "2 silent";
      }
    ];
  };

  wayland.windowManager.hyprland.settings.on = [
    (startupHook ''
      hl.exec_cmd("hyprcursor")
      hl.exec_cmd("[workspace 1] kitty")
      hl.exec_cmd("sleep 1 && kitty +kitten panel -o background_opacity=0 -o dynamic_background_opacity=yes --edge=background --output-name=DP-2 cava")
    '')
  ];
}
