{
  config,
  lib,
  pkgs,
  ...
}: {
  # Create wallpaper helper scripts
  home.packages = with pkgs; [
    (writeShellScriptBin "niri-wallpaper" ''
      #!/usr/bin/env bash
      
      # Set wallpaper using swww (supports animated wallpapers)
      set_wallpaper() {
        local wallpaper_path="$1"
        if [[ -f "$wallpaper_path" ]]; then
          # Ensure swww daemon is running
          if ! pgrep -x "swww-daemon" > /dev/null; then
            swww-daemon &
            sleep 1
          fi
          # Set wallpaper with animation support and proper FPS
          # Use different settings for animated vs static content
          if [[ "$wallpaper_path" =~ \.(gif|mp4|webm)$ ]]; then
            # Animated content - use optimal settings for smooth playbook - faster response
            swww img "$wallpaper_path" --transition-type simple --transition-fps 120 --transition-step 1 --transition-duration 0.3
          else
            # Static images - use fade transition - faster
            swww img "$wallpaper_path" --transition-type fade --transition-duration 0.5 --transition-fps 120
          fi
          # Save path for persistence
          echo "$wallpaper_path" > ~/.wallpaper
          echo "Set wallpaper: $wallpaper_path"
        else
          echo "Wallpaper file not found: $wallpaper_path"
          exit 1
        fi
      }
      
      # Random wallpaper from directory
      random_wallpaper() {
        local wallpaper_dir="$1"
        if [[ -d "$wallpaper_dir" ]]; then
          local wallpaper=$(find "$wallpaper_dir" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" -o -iname "*.gif" \) | shuf -n 1)
          if [[ -n "$wallpaper" ]]; then
            set_wallpaper "$wallpaper"
          else
            echo "No wallpapers found in $wallpaper_dir"
            exit 1
          fi
        else
          echo "Directory not found: $wallpaper_dir"
          exit 1
        fi
      }
      
      case "$1" in
        set)
          set_wallpaper "$2"
          ;;
        random)
          random_wallpaper "''${2:-/home/margot/margotos/wallpapers}"
          ;;
        waypaper)
          waypaper
          ;;
        *)
          echo "Usage: niri-wallpaper {set|random|waypaper} [path]"
          echo "  set <path>     - Set specific wallpaper"
          echo "  random [dir]   - Set random wallpaper from directory (default: /home/margot/margotos/wallpapers)"
          echo "  waypaper       - Launch waypaper GUI"
          exit 1
          ;;
      esac
    '')
    
    (writeShellScriptBin "niri-theme" ''
      #!/usr/bin/env bash
      
      # Simple theme management for Niri
      theme_dir="$HOME/.config/niri/themes"
      current_theme_file="$HOME/.config/niri/current-theme"
      
      mkdir -p "$theme_dir"
      
      case "$1" in
        set)
          theme_name="$2"
          theme_file="$theme_dir/$theme_name.json"
          if [[ -f "$theme_file" ]]; then
            cp "$theme_file" "$HOME/.config/niri/config.json"
            echo "$theme_name" > "$current_theme_file"
            echo "Theme '$theme_name' applied. Restart Niri to see changes."
          else
            echo "Theme not found: $theme_name"
            exit 1
          fi
          ;;
        list)
          echo "Available themes:"
          for theme in "$theme_dir"/*.json; do
            if [[ -f "$theme" ]]; then
              basename "$theme" .json
            fi
          done
          ;;
        current)
          if [[ -f "$current_theme_file" ]]; then
            cat "$current_theme_file"
          else
            echo "No theme set"
          fi
          ;;
        create)
          theme_name="$2"
          if [[ -z "$theme_name" ]]; then
            echo "Usage: niri-theme create <theme_name>"
            exit 1
          fi
          cp "$HOME/.config/niri/config.json" "$theme_dir/$theme_name.json"
          echo "Theme '$theme_name' created from current config"
          ;;
        *)
          echo "Usage: niri-theme {set|list|current|create} [theme_name]"
          echo "  set <name>     - Apply theme"
          echo "  list           - List available themes"
          echo "  current        - Show current theme"
          echo "  create <name>  - Create theme from current config"
          exit 1
          ;;
      esac
    '')
  ];
}