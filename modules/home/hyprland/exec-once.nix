{host, ...}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "wl-paste --type text --watch cliphist store" # Saves text
      "wl-paste --type image --watch cliphist store" # Saves images
      "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user start hyprpolkitagent"

      "killall -q swaybg;sleep .5"
      "killall -q waybar;sleep .5 && waybar"
      "killall -q swaync;sleep .5 && swaync"
      "#wallsetter &"
      "pypr &"
      # "nm-applet --indicator" # Disabled - using waybar network module instead
      "sleep 1.0 && swaybg -i /home/margot/margotos/wallpapers/snowgirl.jpg -m fill -o DP-1 & swaybg -i /home/margot/margotos/wallpapers/vertblack.png -m fill -o DP-3 &"
    ];
  };
}
