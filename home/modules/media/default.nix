{ pkgs, ... }:

{
  home.packages = with pkgs; [
    flatpak
    helvum
    loupe
    vlc
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/3gpp" = [ "vlc.desktop" ];
      "video/3gpp2" = [ "vlc.desktop" ];
      "video/mp2t" = [ "vlc.desktop" ];
      "video/mp4" = [ "vlc.desktop" ];
      "video/mpeg" = [ "vlc.desktop" ];
      "video/ogg" = [ "vlc.desktop" ];
      "video/quicktime" = [ "vlc.desktop" ];
      "video/webm" = [ "vlc.desktop" ];
      "video/x-flv" = [ "vlc.desktop" ];
      "video/x-m4v" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
      "video/x-ms-asf" = [ "vlc.desktop" ];
      "video/x-msvideo" = [ "vlc.desktop" ];
      "video/x-ms-wmv" = [ "vlc.desktop" ];
      "video/x-ogm+ogg" = [ "vlc.desktop" ];
      "image/apng" = [ "org.gnome.Loupe.desktop" ];
      "image/avif" = [ "org.gnome.Loupe.desktop" ];
      "image/bmp" = [ "org.gnome.Loupe.desktop" ];
      "image/gif" = [ "org.gnome.Loupe.desktop" ];
      "image/heic" = [ "org.gnome.Loupe.desktop" ];
      "image/heif" = [ "org.gnome.Loupe.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/jxl" = [ "org.gnome.Loupe.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "image/svg+xml" = [ "org.gnome.Loupe.desktop" ];
      "image/tiff" = [ "org.gnome.Loupe.desktop" ];
      "image/webp" = [ "org.gnome.Loupe.desktop" ];
      "image/x-bmp" = [ "org.gnome.Loupe.desktop" ];
      "image/x-portable-anymap" = [ "org.gnome.Loupe.desktop" ];
      "image/x-portable-bitmap" = [ "org.gnome.Loupe.desktop" ];
      "image/x-portable-graymap" = [ "org.gnome.Loupe.desktop" ];
      "image/x-portable-pixmap" = [ "org.gnome.Loupe.desktop" ];
      "image/x-tga" = [ "org.gnome.Loupe.desktop" ];
      "image/x-xbitmap" = [ "org.gnome.Loupe.desktop" ];
      "image/x-xpixmap" = [ "org.gnome.Loupe.desktop" ];
    };
  };
}
