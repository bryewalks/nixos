{ inputs, lib, ... }:

{
  imports = [ inputs.den.flakeModule ];

  systems = [ "x86_64-linux" ];

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
