{ pkgs
, config
, ...
}: {
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      extraConfig = {
        modi = "drun,run";
        show-icons = true;
        icon-theme = "Papirus";
        font = "JetBrainsMono Nerd Font Mono 14";
        drun-display-format = "{name}";
        display-drun = "";
        display-run = "";
        placeholder-text = "Search...";
        lines = 8;
        columns = 1;
        width = 600;
        location = 0;
        yoffset = -200;
        fixed-num-lines = false;
        hide-scrollbar = true;
        disable-history = false;
        show-match = false;
      };
      theme =
        let
          inherit (config.lib.formats.rasi) mkLiteral;
        in
        {
          "*" = {
            bg = mkLiteral "#1e2328";
            fg = mkLiteral "#ffffff";
            selected = mkLiteral "#3b82f6";
            background-color = mkLiteral "transparent";
            foreground = mkLiteral "#ffffff";
          };
          
          window = {
            transparency = "real";
            width = mkLiteral "600px";
            location = mkLiteral "center";
            anchor = mkLiteral "center";
            x-offset = mkLiteral "0px";
            y-offset = mkLiteral "-200px";
            border-radius = mkLiteral "20px";
            background-color = mkLiteral "@bg";
          };
          
          mainbox = {
            enabled = true;
            spacing = mkLiteral "15px";
            orientation = mkLiteral "vertical";
            children = map mkLiteral [
              "inputbar"
              "listview"
            ];
            background-color = mkLiteral "transparent";
            padding = mkLiteral "20px";
          };
          
          inputbar = {
            enabled = true;
            spacing = mkLiteral "0px";
            padding = mkLiteral "15px";
            border-radius = mkLiteral "15px";
            background-color = mkLiteral "rgba(255, 255, 255, 0.05)";
            children = map mkLiteral [
              "entry"
            ];
          };
          
          entry = {
            enabled = true;
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@fg";
            cursor = mkLiteral "text";
            placeholder = "Search...";
            placeholder-color = mkLiteral "rgba(255, 255, 255, 0.5)";
          };
          
          listview = {
            enabled = true;
            columns = 1;
            lines = 8;
            cycle = true;
            dynamic = true;
            scrollbar = false;
            layout = mkLiteral "vertical";
            fixed-height = false;
            fixed-columns = true;
            spacing = mkLiteral "5px";
            background-color = mkLiteral "transparent";
            margin = mkLiteral "5px 0px 0px 0px";
          };
          
          element = {
            enabled = true;
            spacing = mkLiteral "12px";
            padding = mkLiteral "12px 15px";
            border-radius = mkLiteral "10px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@fg";
            cursor = mkLiteral "pointer";
          };
          
          "element normal.normal" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@fg";
          };
          
          "element selected.normal" = {
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "#ffffff";
          };
          
          "element-icon" = {
            background-color = mkLiteral "transparent";
            size = mkLiteral "24px";
            cursor = mkLiteral "inherit";
          };
          
          "element-text" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
        };
    };
  };
}