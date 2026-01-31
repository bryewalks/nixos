{ config, pkgs, ...}:

{
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-frappe-mauve";
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "frappe";
      accent = "mauve";
      font = "CaskaydiaCove Nerd Font Mono";
      fontSize = "12";
      loginBackground = false;
      background = "backgrounds/wall.jpg";
      userIcon = false;
    })
  ];
}
