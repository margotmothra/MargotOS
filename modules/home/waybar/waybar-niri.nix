{ pkgs
, lib
, host
, config
, ...
}:
let
  inherit (import ../../../hosts/${host}/variables.nix) clock24h;
in
with lib; {
  # Configure & Theme Waybar for Niri
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        margin-top = 4;
        
        # DMS-style layout: Logo left, Clock center, System right
        modules-left = [ "custom/nixos-logo" ];
        modules-center = [ "clock" ];
        modules-right = [ 
          "group/system" 
        ];

        # NixOS logo with pink accent
        "custom/nixos-logo" = {
          format = "NixOS";
          tooltip = false;
          on-click = "rofi -show drun";
        };

        # Clock in center
        "clock" = {
          interval = 1;
          format = if clock24h then "{:%H:%M:%S}" else "{:%I:%M:%S %p}";
          format-alt = "{:%A, %B %d, %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'>{}</span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        # Audio control
        "pulseaudio" = {
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-muted = "󰝟 {volume}%";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰏳";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pavucontrol";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };

        # Notification indicator  
        "custom/notification" = {
          tooltip = false;
          format = "";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
        };

        # System tray
        "tray" = {
          icon-size = 18;
          spacing = 10;
        };

        # Group system widgets with shared border
        "group/system" = {
          orientation = "horizontal";
          modules = [
            "pulseaudio"
            "custom/notification" 
            "tray"
          ];
        };
      }
    ];

    # DMS-style CSS: Invisible bar, visible widgets with backgrounds
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Maple Mono NF", "Font Awesome 6 Free", monospace;
        font-weight: bold;
        font-size: 13px;
        min-height: 0;
      }

      /* Invisible bar background with top padding */
      window#waybar {
        background: transparent;
        color: #F5C2E7;
        margin-top: 4px;
      }

      /* Widget styling - curved styling like Hyprland waybar */
      #custom-nixos-logo {
        background: rgba(245, 194, 231, 0.7);
        color: #191724;
        border-radius: 0px 0px 40px 0px;
        padding: 2px 30px 2px 15px;
        margin: 0px;
        border: none;
        font-size: 12px;
        font-weight: bold;
      }

      #clock {
        background: rgba(49, 66, 68, 0.7);
        color: #F5C2E7;
        border-radius: 0px 0px 0px 40px;
        padding: 2px 15px 2px 30px;
        margin: 0px;
        border: none;
        font-weight: bold;
      }

      /* Top right widgets - curved asymmetric styling */
      #pulseaudio,
      #custom-notification,
      #tray {
        background: rgba(49, 66, 68, 0.7);
        color: #F5C2E7;
        border-radius: 10px 24px 10px 24px;
        padding: 2px 18px;
        margin: 4px 7px 4px 0px;
        border: none;
        font-weight: bold;
      }

      /* System group - disable group background, let individual widgets show */
      #group-system {
        background: transparent;
        border: none;
        margin: 0;
        padding: 0;
      }

      #custom-nixos-logo:hover {
        background: rgba(245, 194, 231, 0.9);
      }

      /* Audio widget - styling handled above */

      #pulseaudio.muted {
        background: rgba(245, 194, 231, 0.7);
        color: #191724;
      }

      /* Notification indicator - styling handled above */
      #custom-notification {
        min-width: 20px;
      }

      /* Tray - styling handled above */
      #tray {
        padding: 2px 8px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: rgba(245, 194, 231, 0.7);
        border-radius: 8px;
      }

      /* Subtle hover effects for all widgets */
      #clock:hover,
      #pulseaudio:hover,
      #custom-notification:hover,
      #tray:hover {
        background: rgba(49, 66, 68, 0.95);
      }

      /* NixOS logo hover already defined above */
    '';
  };
}