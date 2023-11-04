{
  config,
  lib,
  ...
}: let
  settings = {
    options = {
      editor = lib.mkOption {
        type = lib.types.str;
      };
      description = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
in {
  options = {
    profiles = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submoduleWith {
        modules = [settings];
      });
    };
  };
}
