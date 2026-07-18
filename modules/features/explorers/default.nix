{ den, ... }:

{
  den.aspects.features.includes = [ den.aspects.explorers ];

  den.aspects.explorers = {
    nixos =
      { pkgs, ... }:
      {
        programs.thunar = {
          enable = true;
          plugins = with pkgs; [
            thunar-archive-plugin
            thunar-volman
            thunar-media-tags-plugin
          ];
        };

        services.tumbler.enable = true;

        environment.systemPackages = with pkgs; [
          xarchiver
        ];
      };

    provides.to-users.homeManager = {
      xdg.configFile."Thunar/thunarrc".text = ''
        [Configuration]
        LastSidepane=ThunarShortcutsPane
        LastSidepaneVisible=TRUE
      '';
    };
  };
}
