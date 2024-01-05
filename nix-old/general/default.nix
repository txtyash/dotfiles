{
  config,
  lib,
  ...
}: {
  imports = [./modules/settings ./yash];
  config.users.users =
    lib.mapAttrs (
      name: value: {
        description = value.description;
      }
    )
    config.profiles;
}
