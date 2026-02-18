{ config, ... }:

{
  home.file = {
    "Documents".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/Documents";
    "Pictures".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/Pictures";
    "Music".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/Music";
    "Videos".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/Videos";
  };
}
