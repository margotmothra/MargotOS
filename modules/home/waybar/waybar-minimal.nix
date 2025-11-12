{ pkgs
, config
, lib
, ...
}:
let
  terminal = "kitty";
in
with lib; {
  # Ensure icon fonts are available
  home.packages = with pkgs; [
    font-awesome
    # Font viewers and managers
    gnome-font-viewer       # Simple font viewer
    font-manager            # Advanced font manager
    # Maple Mono NF should already be available system-wide
  ];
  # Minimal Waybar Configuration
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 40;
        margin-top = 0;
        margin-bottom = 0;

        # Clean widget arrangement
        modules-left = [ "custom/nixos" "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "custom/notification" "tray" "custom/exit" ];

        "custom/nixos" = {
          tooltip = false;
          format = "❄️";
          on-click = "rofi -show drun";
        };

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
          sort-by-number = true;
          active-only = false;
          show-special = false;
        };

        "hyprland/window" = {
          max-length = 50;
          separate-outputs = false;
        };

        "clock" = {
          format = "{:%H:%M}";
          tooltip-format = "<big>{:%A, %B %d, %Y}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "pulseaudio" = {
          format = "VOL {volume}%";
          format-muted = "MUTE {volume}%";
          on-click = "pavucontrol";
          tooltip = false;
        };

        "custom/notification" = {
          tooltip = false;
          format = "BELL {}";
          exec = "swaync-client -swb | jq -r '.text // \"0\"'";
          on-click = "swaync-client -t";
          interval = 2;
        };

        "tray" = {
          spacing = 10;
        };

        "custom/exit" = {
          tooltip = false;
          format = "⏻";
          on-click = "sleep 0.1 && wlogout";
        };
      }
    ];
    
    style = ''
      * {
        font-size: 14px;
        font-family: Hackgen-NF, Font Awesome, sans-serif;
        font-weight: normal;
      }

      window#waybar {
        background-color: rgba(30, 30, 30, 0);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        color: #ffffff;
      }

      #custom-nixos {
        margin: 4px 4px 4px 8px;
        padding: 4px 12px;
        color: #ffffff;
        background: rgba(255, 255, 255, 0.05);
        border-radius: 4px;
      }

      #workspaces {
        background: transparent;
        margin: 4px;
        padding: 0;
      }

      #workspaces button {
        padding: 4px 8px;
        margin: 0 2px;
        border-radius: 4px;
        border: none;
        color: #888888;
        background: transparent;
        transition: all 0.2s ease;
      }

      #workspaces button.active {
        color: #ffffff;
        background: rgba(255, 255, 255, 0.1);
      }

      #workspaces button:hover {
        color: #cccccc;
        background: rgba(255, 255, 255, 0.05);
      }

      #window {
        margin: 4px;
        padding: 4px 12px;
        color: #cccccc;
        background: transparent;
      }

      #clock {
        margin: 4px;
        padding: 4px 16px;
        color: #ffffff;
        background: rgba(255, 255, 255, 0.05);
        border-radius: 4px;
      }

      #pulseaudio,
      #custom-notification {
        margin: 4px 2px;
        padding: 4px 12px;
        color: #ffffff;
        background: rgba(255, 255, 255, 0.05);
        border-radius: 4px;
      }

      #tray {
        margin: 4px 4px;
        padding: 4px 8px;
        background: rgba(255, 255, 255, 0.05);
        border-radius: 4px;
      }

      #custom-exit {
        margin: 4px 8px 4px 4px;
        padding: 4px 12px;
        color: #ffffff;
        background: rgba(255, 255, 255, 0.05);
        border-radius: 4px;
      }

      #custom-exit:hover {
        background: rgba(255, 100, 100, 0.2);
      }

      #battery.warning {
        color: #ffaa00;
      }

      #battery.critical {
        color: #ff4444;
        background: rgba(255, 68, 68, 0.1);
      }

      #network.disconnected {
        color: #888888;
      }

      tooltip {
        background: rgba(30, 30, 30, 0.95);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 4px;
        color: #ffffff;
      }
    '';
  };
}