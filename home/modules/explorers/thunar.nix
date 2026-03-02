{ pkgs, ... }:

{
  home.packages = with pkgs; [
    thunar
    thunar-archive-plugin
    thunar-volman
    thunar-media-tags-plugin
    tumbler
    gvfs
  ];

  xdg.configFile."Thunar/thunarrc".text = ''
    [Configuration]
    LastSidepane=ThunarShortcutsPane
    LastSidepaneVisible=TRUE
  '';
}
