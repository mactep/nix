{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.fish;
  enable = cfg.enable && config.programs.fish.enable;

  isLatte = cfg.flavor == "latte";
  flavor = if isLatte then "mocha" else cfg.flavor;

  themeName = "Catppuccin ${lib.toSentenceCase flavor}";
in

{
  options.catppuccin.fish = catppuccinLib.mkCatppuccinOption { name = "fish"; };

  config = lib.mkIf enable {
    warnings = lib.optional isLatte "fish by default uses Latte as the light theme, defaulting to Mocha.";

    xdg.configFile."fish/themes/${themeName}.theme".source = "${sources.fish}/${themeName}.theme";

    programs.fish.shellInit = ''
      fish_config theme choose "${themeName}"
    '';
  };
}
