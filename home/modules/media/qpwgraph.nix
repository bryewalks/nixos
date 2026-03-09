{ pkgs, lib, ... }:

let
  dracula = import ../themes/dracula.nix;
  # Opened an issue with ALSA port color not persisting.
  # https://github.com/rncbc/qpwgraph/issues/84
  # In the meantime we can use the below patch.
  qpwgraph = pkgs.qpwgraph.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [
      ./qpwgraph-alsa-color.patch
    ];
  });
in
{
  home.packages = [
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
        "0x172973e6": "${dracula.cyan}",
        "0x2c2fdc12": "${dracula.purple}",
        "0x30fc78a9": "${dracula.red}",
        "0x50c34e7e": "${dracula.yellow}",
        "0xb91441cf": "${dracula.green}",
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
}
