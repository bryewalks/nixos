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
  };

  # TODO: Use nix syntax once home-manager supports 0.53 syntax
  wayland.windowManager.hyprland.extraConfig = ''
    windowrule {
        name = games-workspace
        workspace = 1 silent
        match:class = ^(steam_app_.*|lutris|HytaleClient|bottles|itch|minigalaxy|gamescope|playnite.*|chiaki|moonlight|.*[Ww]ine.*|com.moonlight_stream.Moonlight|com.hypixel.HytaleLauncher)$
    }

    # Discord Workspace 2
    windowrule {
        name = discord-workspace
        workspace = 2 silent
        match:class = ^(discord|com.discordapp.Discord|vesktop|dev.vencord.Vesktop)$
    }

    # Launchers Workspace 4
    windowrule {
        name = launchers-workspace
        workspace = 4 silent
        match:class = ^(steam|com.valvesoftware.Steam|itch|io.itch.itch|heroic|com.heroicgameslauncher.hgl|r2modman)$
    }
  '';
}
