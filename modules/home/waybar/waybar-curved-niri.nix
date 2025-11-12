{ pkgs
, lib
, host
, config
, ...
}:
let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ../../../hosts/${host}/variables.nix) clock24h;
in
with lib; {
  # Configure & Theme Waybar for Niri (Curved Style)
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = [
          "custom/startmenu"
        ];
        modules-center = [ 
          "clock" 
        ];
        modules-right = [
          "pulseaudio"
          "cpu"
          "memory"
          "custom/niribindings"
          "custom/notification"
          "battery"
          "tray"
          "custom/exit"
        ];

        "clock" = {
          format =
            if clock24h == true
            then '' {:L%H:%M}''
            else '' {:L%I:%M %p}'';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };
        "memory" = {
          interval = 5;
          format = "󰍛 {}%";
          tooltip = true;
        };
        "cpu" = {
          interval = 5;
          format = "󰻠 {usage:2}%";
          tooltip = true;
        };
        "disk" = {
          format = " {free}";
          tooltip = true;
        };
        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "tray" = {
          spacing = 12;
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "sleep 0.1 && pavucontrol";
        };
        "custom/exit" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && wlogout";
        };
        "custom/startmenu" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && rofi -show drun";
        };
        "custom/niribindings" = {
          tooltip = false;
          format = "󱕴";
          on-click = "sleep 0.1 && bash -c \"echo -e 'Mod+Return - Terminal\\\\nMod+Tab - Overview\\\\nMod+R - Launcher\\\\nMod+B - Browser\\\\nMod+I - Discord\\\\nMod+G - GIMP\\\\nMod+M - Spotify\\\\nMod+S - Screenshot\\\\nMod+V - Clipboard\\\\nMod+/ - Keybinds help' | rofi -dmenu -p 'Niri Keybinds'\"";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && swaync-client -t -sw";
          escape = true;
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          on-click = "";
          tooltip = false;
        };
      }
    ];
    style = concatStrings [
      ''
        * {
          font-family: JetBrainsMono Nerd Font Mono;
          font-size: 16px;
          border-radius: 0px;
          border: none;
          min-height: 0px;
        }
        window#waybar {
          background: rgba(0,0,0,0);
        }
        tooltip {
          background: #${config.lib.stylix.colors.base00};
          border: 1px solid #${config.lib.stylix.colors.base08};
          border-radius: 12px;
        }
        tooltip label {
          color: #${config.lib.stylix.colors.base08};
        }
        #pulseaudio, #cpu, #memory {
          font-weight: bold;
          margin: 4px 0px;
          margin-left: 7px;
          padding: 0px 18px;
          background: #${config.lib.stylix.colors.base04};
          color: #${config.lib.stylix.colors.base00};
          border-radius: 24px 10px 24px 10px;
        }
        #custom-startmenu {
          color: #${config.lib.stylix.colors.base0B};
          background: #${config.lib.stylix.colors.base02};
          font-size: 28px;
          margin: 0px;
          padding: 0px 30px 0px 15px;
          border-radius: 0px 0px 40px 0px;
        }
        #custom-niribindings, #network, #battery,
        #custom-notification, #tray, #custom-exit {
          font-weight: bold;
          background: #${config.lib.stylix.colors.base0F};
          color: #${config.lib.stylix.colors.base00};
          margin: 4px 0px;
          margin-right: 7px;
          border-radius: 10px 24px 10px 24px;
          padding: 0px 18px;
        }
        #clock {
          font-weight: bold;
          color: #0D0E15;
          background: linear-gradient(90deg, #${config.lib.stylix.colors.base0E}, #${config.lib.stylix.colors.base0C});
          margin: 0px;
          padding: 0px 30px;
          border-radius: 0px 0px 40px 40px;
          min-width: 120px;
        }
      ''
    ];
  };
}