{
  pkgs,
  host,
  ...
}: {
  # Styling Options
  stylix = {
    enable = true;
    # Rose Pine Dawn theme
    base16Scheme = {
      scheme = "Rosé Pine Dawn";
      author = "jishnurajendran";
      base00 = "faf4ed"; # $base (background)
      base01 = "fffaf3"; # $surface
      base02 = "f2e9e1"; # $overlay
      base03 = "9893a5"; # $muted
      base04 = "797593"; # $subtle
      base05 = "26233a"; # $text (darker for better contrast)
      base06 = "26233a"; # $text (darker for better contrast)
      base07 = "575279"; # $highlightHigh
      base08 = "b4637a"; # $love
      base09 = "ea9d34"; # $gold
      base0A = "d7827e"; # $rose
      base0B = "286983"; # $pine
      base0C = "56949f"; # $foam
      base0D = "907aa9"; # $iris
      base0E = "286983"; # $pine
      base0F = "26233a"; # $text (darker for better contrast)
    };
    targets.nixos-icons.enable = false;
    targets.console.enable = false;
    polarity = "light";
    opacity.terminal = 1.0;
    cursor = {
      package = pkgs.rose-pine-hyprcursor;
      name = "rose-pine-hyprcursor";
      size = 24;
    };
    fonts = {
      monospace = {
        package = pkgs.maple-mono.truetype;
        name = "Maple Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };
}
