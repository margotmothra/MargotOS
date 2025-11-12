{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.niri = {
    settings = {
      input = {
        keyboard.xkb = {
          layout = "us";
          options = "caps:lalt";
        };

        touchpad = {
          tap = true;
          natural-scroll = true;
        };

        mouse = {
          natural-scroll = false;
        };
        
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };
      };

      layout = {
        gaps = 8;
        center-focused-column = "never";
        preset-column-widths = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
        ];
        default-column-width = {proportion = 0.5;};
        border = {
          enable = true;
          width = 2;
          active.color = "#F5C2E7";
          inactive.color = "#6b7280";
        };
      };

      prefer-no-csd = true;

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      window-rules = [
        # Default rule for inactive windows - lower opacity
        {
          matches = [
            {is-focused = false;}
          ];
          opacity = 0.8;
        }
        
        # Keep media applications at full opacity (always)
        {
          matches = [
            {app-id = "^discord$";}
            {app-id = "^firefox$";}
            {app-id = "^brave-browser$";}
            {app-id = "^chromium-browser$";}
            {app-id = "^vlc$";}
            {app-id = "^mpv$";}
            {app-id = "^spotify$";}
            {title = ".*YouTube.*";}
            {title = ".*Netflix.*";}
            {title = ".*Twitch.*";}
          ];
          opacity = 1.0;
        }
        
        # Active terminals at 90% opacity (this comes last to override other rules)
        {
          matches = [
            {app-id = "^kitty$"; is-focused = true;}
            {app-id = "^alacritty$"; is-focused = true;}
            {app-id = "^wezterm$"; is-focused = true;}
            {app-id = "^ghostty$"; is-focused = true;}
          ];
          opacity = 0.9;
        }
      ];

      outputs = {
        "DP-3" = {
          enable = true;
          position = {
            x = 0;
            y = 0;
          };
        };
        "HDMI-A-1" = {
          enable = true;
          position = {
            x = 1920;  # Adjust this based on DP-3's resolution
            y = 0;
          };
        };
      };

      # Animations - correct format
      animations = {
        slowdown = 1.0;

        horizontal-view-movement = {
          kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };

        window-open = {
          kind.easing = {
            duration-ms = 150;
            curve = "ease-out-expo";
          };
        };

        config-notification-open-close = {
          kind.spring = {
            damping-ratio = 0.6;
            stiffness = 1000;
            epsilon = 0.001;
          };
        };
      };

      spawn-at-startup = [
        {command = ["waybar"];}
        {command = ["${pkgs.writeShellScript "start-swww-and-wallpaper" ''
          # Kill any existing wallpaper managers and restart fresh for proper animation support
          pkill swaybg 2>/dev/null || true
          swww kill 2>/dev/null || true
          sleep 1
          swww-daemon --format xrgb --no-cache &
          sleep 3
          
          # Restore wallpaper if saved
          if [ -f ~/.wallpaper ]; then
            WALLPAPER=$(cat ~/.wallpaper)
            if [ -f "$WALLPAPER" ]; then
              if [[ "$WALLPAPER" =~ \.(gif|mp4|webm)$ ]]; then
                swww img "$WALLPAPER" --transition-type none
              else
                swww img "$WALLPAPER" --transition-type fade --transition-duration 1 --transition-fps 120
              fi
            fi
          fi
          
          # Wait a bit longer then re-apply wallpaper to override any other services
          sleep 5
          if [ -f ~/.wallpaper ]; then
            WALLPAPER=$(cat ~/.wallpaper)
            if [ -f "$WALLPAPER" ] && [[ "$WALLPAPER" =~ \.(gif|mp4|webm)$ ]]; then
              swww img "$WALLPAPER" --transition-type none
            fi
          fi
          
          # Kill swaybg again in case it started after us
          sleep 2
          pkill swaybg 2>/dev/null || true
        ''}"];}
        # DankMaterialShell is now launched via systemd service instead
        # {command = ["${pkgs.writeShellScript "start-dankshell" ''
        #   export WAYLAND_DISPLAY="$WAYLAND_DISPLAY"
        #   export XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR"
        #   ${inputs.quickshell.packages.${pkgs.system}.default}/bin/quickshell -c ${inputs.dankMaterialShell.packages.${pkgs.system}.default}/etc/xdg/quickshell/dms
        # ''}"];}
      ];

      binds = {
        # DankMaterialShell IPC bindings (non-conflicting keys only)
        
        # Additional audio control (microphone)
        "XF86AudioMicMute".action.spawn = ["dms" "ipc" "call" "audio" "micmute"];
        
        # Theme toggle
        "Mod+Shift+T".action.spawn = ["dms" "ipc" "call" "theme" "toggle"];
        
        # Quick access to modals (avoiding conflicts)
        "Mod+comma".action.spawn = ["dms" "ipc" "call" "settings" "toggle"];
        "Mod+Escape".action.spawn = ["dms" "ipc" "call" "powermenu" "toggle"];
        
        # Screen lock (using unique key combination)
        "Mod+Ctrl+L".action.spawn = ["dms" "ipc" "call" "lock" "lock"];
        
        # Process list (using Ctrl+P to avoid conflicts)
        "Mod+Ctrl+P".action.spawn = ["dms" "ipc" "call" "processlist" "toggle"];
        
        # Notepad
        "Mod+Shift+P".action.spawn = ["dms" "ipc" "call" "notepad" "toggle"];
        
        # Bar toggle (changed to avoid browser conflict)
        "Mod+Shift+B".action.spawn = ["dms" "ipc" "call" "bar" "toggle"];
        
        # File browser (using unique key combination)
        "Mod+Ctrl+F".action.spawn = ["dms" "ipc" "call" "file" "browse" "wallpaper"];
        
        # Night mode toggle (using different key to avoid conflicts)
        "Mod+Ctrl+N".action.spawn = ["dms" "ipc" "call" "night" "toggle"];
        
        # Control center (using different key to avoid color picker conflict)
        "Mod+Ctrl+C".action.spawn = ["dms" "ipc" "call" "control-center" "toggle"];
        
        # DankDash wallpaper browser (using unique key combination)
        "Mod+Ctrl+D".action.spawn = ["dms" "ipc" "call" "dankdash" "wallpaper"];
      };
    };
  };
}
