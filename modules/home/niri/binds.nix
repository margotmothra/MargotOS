{
  config,
  lib,
  pkgs,
  host,
  ...
}:
let
  inherit
    (import ../../../hosts/${host}/variables.nix)
    browser
    terminal
    ;
in
{
  programs.niri.settings = {
    binds = {
      # Applications (matching Hyprland setup)
      "Mod+Return".action.spawn = [terminal];
      "Mod+Tab".action."toggle-overview" = [];
      "Mod+D".action.spawn = ["rofi" "-show" "drun"];
      "Mod+R".action.spawn = ["rofi" "-show" "drun"];
      "Mod+Shift+W".action.spawn = ["web-search"];
      "Mod+Alt+W".action.spawn = ["niri-wallpaper" "waypaper"];
      "Mod+Ctrl+W".action.spawn = ["niri-wallpaper" "random"];
      "Mod+Shift+Alt+W".action.spawn = ["niri-wallpaper" "random"];
      "Mod+Shift+N".action.spawn = ["swaync-client" "-rs"];
      "Mod+B".action.spawn = [browser];
      "Mod+Y".action.spawn = ["kitty" "-e" "yazi"];
      "Mod+E".action.spawn = ["emopicker9000"];
      "Mod+S".action.spawn = ["screenshootin"];
      "Mod+Ctrl+S".action.screenshot = [];
      "Mod+Shift+S".action."screenshot-window" = [];
      "Mod+Alt+S".action."screenshot-screen" = [];
      "Mod+I".action.spawn = ["discord-niri"];
      "Mod+O".action.spawn = ["obs"];
      "Mod+C".action.spawn = ["hyprpicker" "-a"];
      "Mod+G".action.spawn = ["gimp"];
      "Mod+T".action.spawn = ["thunar"];
      "Mod+M".action.spawn = ["spotify"];
      "Mod+V".action.spawn = ["bash" "-c" "cliphist list | rofi -dmenu | cliphist decode | wl-copy"];

      # Niri-specific tools
      "Mod+P".action.spawn = ["niri-float-sticky"];  # Toggle floating/sticky

      # Window management (adapted for Niri's column system)
      "Mod+W".action."close-window" = [];
      "Mod+Q".action."close-window" = [];

      # Focus movement (Niri column-aware)
      "Mod+H".action."focus-column-left" = [];
      "Mod+L".action."focus-column-right" = [];
      "Mod+J".action."focus-window-down" = [];
      "Mod+K".action."focus-window-up" = [];
      "Mod+Left".action."focus-column-left" = [];
      "Mod+Right".action."focus-column-right" = [];
      "Mod+Down".action."focus-window-down" = [];
      "Mod+Up".action."focus-window-up" = [];
      
      # Mouse scroll column navigation
      "Mod+WheelScrollUp".action."focus-column-right" = [];
      "Mod+WheelScrollDown".action."focus-column-left" = [];

      # Move windows/columns (Niri-specific)
      "Mod+Shift+H".action."move-column-left" = [];
      "Mod+Shift+L".action."move-column-right" = [];
      "Mod+Shift+J".action."move-window-down" = [];
      "Mod+Shift+K".action."move-window-up" = [];
      "Mod+Shift+Left".action."move-column-left" = [];
      "Mod+Shift+Right".action."move-column-right" = [];
      "Mod+Shift+Down".action."move-window-down" = [];
      "Mod+Shift+Up".action."move-window-up" = [];

      # Consume into column (Niri's equivalent to swapping)
      "Mod+Alt+H".action."consume-window-into-column" = [];
      "Mod+Alt+L".action."consume-or-expel-window-right" = [];
      "Mod+Alt+Left".action."consume-window-into-column" = [];
      "Mod+Alt+Right".action."consume-or-expel-window-right" = [];

      # Column width management (Niri's tiling control)
      "Mod+Equal".action."set-column-width" = "+10%";
      "Mod+Minus".action."set-column-width" = "-10%";
      "Mod+Shift+Equal".action."set-window-height" = "+10%";
      "Mod+Shift+Minus".action."set-window-height" = "-10%";

      # Preset column widths (Niri feature)
      "Mod+Ctrl+R".action."switch-preset-column-width" = [];
      "Mod+F".action."maximize-column" = [];
      "Mod+Shift+F".action."fullscreen-window" = [];

      # Workspaces (1-10 to match Hyprland)
      "Mod+1".action."focus-workspace" = 1;
      "Mod+2".action."focus-workspace" = 2;
      "Mod+3".action."focus-workspace" = 3;
      "Mod+4".action."focus-workspace" = 4;
      "Mod+5".action."focus-workspace" = 5;
      "Mod+6".action."focus-workspace" = 6;
      "Mod+7".action."focus-workspace" = 7;
      "Mod+8".action."focus-workspace" = 8;
      "Mod+9".action."focus-workspace" = 9;
      "Mod+0".action."focus-workspace" = 10;

      "Mod+Shift+1".action."move-column-to-workspace" = 1;
      "Mod+Shift+2".action."move-column-to-workspace" = 2;
      "Mod+Shift+3".action."move-column-to-workspace" = 3;
      "Mod+Shift+4".action."move-column-to-workspace" = 4;
      "Mod+Shift+5".action."move-column-to-workspace" = 5;
      "Mod+Shift+6".action."move-column-to-workspace" = 6;
      "Mod+Shift+7".action."move-column-to-workspace" = 7;
      "Mod+Shift+8".action."move-column-to-workspace" = 8;
      "Mod+Shift+9".action."move-column-to-workspace" = 9;
      "Mod+Shift+0".action."move-column-to-workspace" = 10;

      # Workspace navigation
      "Mod+Ctrl+Right".action."focus-workspace-down" = [];
      "Mod+Ctrl+Left".action."focus-workspace-up" = [];

      # Monitor navigation - using Caps Lock (remapped to Alt) as modifier
      "Alt+Left".action."focus-monitor-left" = [];
      "Alt+Right".action."focus-monitor-right" = [];
      "Alt+WheelScrollUp".action."focus-monitor-right" = [];
      "Alt+WheelScrollDown".action."focus-monitor-left" = [];

      # Screenshots
      "Print".action.screenshot = [];
      "Shift+Print".action."screenshot-window" = [];

      # Media keys
      "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"];
      "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
      "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
      "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];
      "XF86AudioPause".action.spawn = ["playerctl" "play-pause"];
      "XF86AudioNext".action.spawn = ["playerctl" "next"];
      "XF86AudioPrev".action.spawn = ["playerctl" "previous"];
      "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "5%-"];
      "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "+5%"];

      # Help and System
      "Mod+Slash".action.spawn = ["bash" "-c" "echo -e 'Mod+Return - Terminal\\nMod+Tab - Overview\\nMod+R - Launcher\\nMod+B - Browser\\nMod+I - Discord\\nMod+G - GIMP\\nMod+M - Spotify\\nMod+S - Screenshot\\nMod+V - Clipboard\\nMod+/ - Keybinds help' | rofi -dmenu -p 'Keybinds'"];
      "Mod+Shift+Slash".action.spawn = ["bash" "-c" "echo -e 'Mod+Space - Spotlight\\nMod+Return - Terminal\\nMod+Tab - Overview\\nMod+R - Launcher\\nMod+B - Browser\\nMod+I - Discord\\nMod+G - GIMP\\nMod+M - Spotify\\nMod+S - Screenshot\\nMod+V - Clipboard\\nMod+/ - Keybinds help' | rofi -dmenu -p 'Keybinds'"];
      
      # System
      "Mod+Shift+C".action.quit = [];
      "Mod+Shift+E".action.quit = [];
    };
  };
}
