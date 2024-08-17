let
 unstable = import <nixpkgs-unstable> { config = { allowUnfree = true; }; };
 nixgl = import <nixgl> { config = { allowUnfree = true; }; };
in

{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        kooha
        unstable.vscode
        unstable.gitkraken
        unstable.google-chrome
        unstable._1password-gui
        unstable.obsidian
        unstable.discord
        unstable.spotify
        unstable.slack
        unstable.orca-slicer
      ];
    };
  };
}
