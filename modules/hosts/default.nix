# Declares the diskoConfigurations flake output so each host can export its
# own disko config from its folder (undeclared flake outputs cannot merge
# across files). Hosts register themselves in modules/hosts/<name>/.
{ lib, flake-parts-lib, ... }:

{
  options.flake = flake-parts-lib.mkSubmoduleOptions {
    diskoConfigurations = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.raw;
      default = { };
      description = "Per-host disko configurations, consumed by disko-install.";
    };
  };
}
