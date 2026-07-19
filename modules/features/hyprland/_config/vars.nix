{ lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    mainMod = {
      _var = "SUPER";
    };
    terminal = {
      _var = "kitty";
    };
    fileManager = {
      _var = "thunar";
    };
    menu = {
      _var = "rofi -show drun";
    };
    audio = {
      _var = "qpwgraph";
    };
    browser = {
      _var = "zen-beta --new-window";
    };
    music = {
      _var = "kitty cmus";
    };
    webapp = {
      _var = lib.generators.mkLuaInline ''browser .. " -P WebApp --class WebApp"'';
    };
    movies = {
      _var = "stremio --no-window-decorations";
    };
    voip = {
      _var = "discord";
    };
    passwordManager = {
      _var = "bitwarden";
    };
    steam = {
      _var = "steam";
    };
    gmail = {
      _var = "zen-beta --no-remote --new-window -P WebApp-gmail --class WebApp-gmail https://gmail.com";
    };
    proton = {
      _var = "zen-beta --no-remote --new-window -P WebApp-proton --class WebApp-proton https://mail.proton.me";
    };
    claude = {
      _var = "zen-beta --no-remote --new-window -P WebApp-claude --class WebApp-claude https://claude.ai";
    };
  };
}
