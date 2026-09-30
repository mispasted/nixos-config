# privileged-programs/default.nix
# Simply imports all subdirectories containing a default.nix
let
  here = ./.;
  entries = builtins.readDir here;

  moduleDirectories = builtins.filter
    (name:
      entries.${name} == "directory"
      && builtins.pathExists (here + "/${name}/default.nix")
    )
    (builtins.attrNames entries);
in
{
  imports = map (name: here + "/${name}") moduleDirectories;
}