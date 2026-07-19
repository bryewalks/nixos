{ den, ... }:

{
  den.aspects.audio.provides.to-users.homeManager =
    { config, pkgs, lib, ... }:
    let
      palette = config.theme.palette;
    in
    {
      home.packages = with pkgs; [
        qpwgraph
      ];

      home.activation.qpwgraphConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        config="$HOME/.config/rncbc.org/qpwgraph.conf"
        mkdir -p "$(dirname "$config")"
        ${pkgs.python3}/bin/python3 <<'PYEOF'
    import configparser, os

    path = os.path.expanduser("~/.config/rncbc.org/qpwgraph.conf")
    cfg = configparser.RawConfigParser()
    cfg.optionxform = str  # preserve key case
    cfg.read(path)

    desired = {
        "GraphColors": {
            "0x172973e6": "${palette.cyan}",
            "0x2c2fdc12": "${palette.purple}",
            "0x30fc78a9": "${palette.red}",
            "0x50c34e7e": "${palette.yellow}",
            "0xb91441cf": "${palette.green}",
        },
        "SystemTray": {
            "Enabled": "true",
            "QueryClose": "false",
            "StartMinimized": "false",
        },
    }

    for section, values in desired.items():
        if not cfg.has_section(section):
            cfg.add_section(section)
        for key, val in values.items():
            cfg.set(section, key, val)

    with open(path, "w") as f:
        cfg.write(f)
    PYEOF
      '';
    };
}
