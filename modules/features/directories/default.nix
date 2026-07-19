{ den, lib, ... }:

let
  # Hosts that declare a storageRoot capability keep their media dirs there.
  storage-symlinks =
    root:
    { config, ... }:
    {
      home.file = {
        "Documents".source = config.lib.file.mkOutOfStoreSymlink "${root}/Documents";
        "Pictures".source = config.lib.file.mkOutOfStoreSymlink "${root}/Pictures";
        "Music".source = config.lib.file.mkOutOfStoreSymlink "${root}/Music";
        "Videos".source = config.lib.file.mkOutOfStoreSymlink "${root}/Videos";
      };
    };
in
{
  den.aspects.workstation.includes = [ den.aspects.directories ];

  den.aspects.directories =
    { host, ... }:
    {
      provides.to-users.homeManager =
        { lib, ... }:
        {
          imports = lib.optionals (host ? storageRoot) [ (storage-symlinks host.storageRoot) ];

          xdg.userDirs = {
            enable = true;
            createDirectories = true;
            desktop = null;
            documents = "$HOME/Documents";
            download = "$HOME/Downloads";
            music = "$HOME/Music";
            pictures = "$HOME/Pictures";
            videos = "$HOME/Videos";
            publicShare = null;
            templates = null;
            setSessionVariables = false;
          };

          home.activation.createUserDirectories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            mkdir -p "$HOME/Code" "$HOME/Games"
          '';
        };
    };
}
