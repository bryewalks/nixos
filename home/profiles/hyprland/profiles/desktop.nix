{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-2, 2560x1440@180, 0x0, 1"
      "DP-1, 2560x1440@180, 2560x0, 1"
    ];

    workspace = [
      "name:1, monitor:DP-2, default:true"
      "name:3, monitor:DP-2, default:true"
      "name:2, monitor:DP-1, default:true"
      "name:4, monitor:DP-1, default:true"
    ];

    "exec-once" = [
      "hyprcursor"
      "~/.config/hypr/scripts/startup.sh"
    ];

    windowrulev2 = [
      "workspace 1 silent,class:^(steam_app_.*|lutris|HytaleClient|bottles|itch|minigalaxy|gamescope|playnite.*|chiaki|moonlight|.*[Ww]ine.*|com.moonlight_stream.Moonlight|com.hypixel.HytaleLauncher)$"
      "workspace 2 silent,class:^(discord|com.discordapp.Discord|vesktop|dev.vencord.Vesktop)$"
      "workspace 4 silent,class:^(steam|com.valvesoftware.Steam|itch|io.itch.itch|heroic|com.heroicgameslauncher.hgl|r2modman)$"
    ];
  };
}
