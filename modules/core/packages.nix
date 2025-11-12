{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = true; # Firefox is not installed by default
    hyprland = {
      enable = true; # set this so desktop file is created
      withUWSM = false;
    };
    niri.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    adb.enable = true;
    hyprlock.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # xremap configuration to remap CapsLock to Alt
  services.xremap = {
    enable = true;
    withWlroots = true;
    config = {
      modmap = [
        {
          name = "Global";
          remap = {"CapsLock" = "Alt_L";};
        }
      ];
    };
  };

  # niri tiling behavior service
  systemd.user.services.niri-tile-to-n = {
    description = "Niri auto-tiling behavior modifier";
    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/niri_tile_to_n.py -n 3";
      Restart = "always";
      RestartSec = "5";
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Hyprland systeminfo QT  (Optional)
    #inputs.hyprsysteminfo.packages.${pkgs.system}.default

    #aider-chat # AI in terminal (Optional: Client only)
    amfora # Fancy Terminal Browser For Gemini Protocol
    appimage-run # Needed For AppImage Support
    brave # Brave Browser
    brightnessctl # For Screen Brightness Control
    claude-code # Claude code terminal AI (Optional: Client only)
    cliphist # Clipboard manager using rofi menu
    cmatrix # Matrix Movie Effect In Terminal
    cowsay # Great Fun Terminal Program
    discord # Stable client
    (pkgs.writeShellScriptBin "discord-niri" ''
      # Discord wrapper for niri - force X11 backend
      export DISPLAY=:0
      export GDK_BACKEND=x11
      export XDG_SESSION_TYPE=x11
      exec ${pkgs.discord}/bin/discord \
        --disable-gpu-sandbox \
        --disable-dev-shm-usage \
        --no-sandbox \
        "$@"
    '')
    discord-canary # beta  client
    docker-compose # Allows Controlling Docker From A Single File
    duf # Utility For Viewing Disk Usage In Terminal
    dysk # Disk space util nice formattting
    eza # Beautiful ls Replacement
    ffmpeg # Terminal Video / Audio Editing
    file-roller # Archive Manager
    gedit # Simple Graphical Text Editor
    gemini-cli # CLI AI client ONLY (optional)
    gimp # Great Photo Editor
    glxinfo # needed for inxi diag util
    greetd.tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
    htop # Simple Terminal Based System Monitor
    hyprpicker # Color Picker
    hyprshot # Screen capture
    eog # For Image Viewing
    inxi # CLI System Information Tool
    killall # For Killing All Instances Of Programs
    libnotify # For Notifications
    lm_sensors # Used For Getting Hardware Temps
    lolcat # Add Colors To Your Terminal Command Output
    lshw # Detailed Hardware Information
    mpv # Incredible Video Player
    ncdu # Disk Usage Analyzer With Ncurses Interface
    nixfmt-rfc-style # Nix Formatter
    nwg-displays # configure monitor configs via GUI
    onefetch # provides zsaneyos build info on current system
    pavucontrol # For Editing Audio Levels & Devices
    pciutils # Collection Of Tools For Inspecting PCI Devices
    picard # For Changing Music Metadata & Getting Cover Art
    pkg-config # Wrapper Script For Allowing Packages To Get Info On Others
    playerctl # Allows Changing Media Volume Through Scripts
    python3 # Python interpreter for scripts
    rhythmbox # audio player
    ripgrep # Improved Grep
    socat # Needed For Screenshots
    unrar # Tool For Handling .rar Files
    unzip # Tool For Handling .zip Files
    usbutils # Good Tools For USB Devices
    uwsm # Universal Wayland Session Manager (optional must be enabled)
    v4l-utils # Used For Things Like OBS Virtual Camera
    warp-terminal # Terminal with AI support build in
    waypaper # Change wallpaper
    swaybg # Wallpaper daemon for Wayland
    swww # Animated wallpaper daemon
    wget # Tool For Fetching Files With Links
    xwayland-satellite # XWayland rootless server for niri
    ytmdl # Tool For Downloading Audio From YouTube
    ibm-plex
    spotify
    obsidian
    vscode
    pastel
    themix-gui #theme maker
    speedcrunch
    (pkgs.writeShellScriptBin "steam-niri" ''
      # Steam wrapper for niri - force X11 backend
      export DISPLAY=:0
      export GDK_BACKEND=x11
      export XDG_SESSION_TYPE=x11
      exec ${pkgs.steam}/bin/steam "$@"
    '')
    youtube-music
    prismlauncher
    lutris
    (pkgs.writeShellScriptBin "lutris-niri" ''
      # Lutris wrapper for niri - force X11 backend for Wine compatibility
      export DISPLAY=:0
      export GDK_BACKEND=x11
      export XDG_SESSION_TYPE=x11
      exec ${pkgs.lutris}/bin/lutris "$@"
    '')
    lazygit
    lazydocker
    chatgpt-cli
    librewolf-bin
    inputs.zen-browser.packages.${pkgs.system}.default
    visidata # Terminal-based data exploration tool
    xremap # Key remapper for X11 and Wayland (wlroots support)
    oguri # Animated wallpaper daemon for Wayland

    # Niri-specific tools
    (pkgs.writeShellScriptBin "niri-float-sticky" ''
      # Toggle floating windows
      niri msg action toggle-window-floating
    '')

    # Niri screen time tracker
    (pkgs.buildGoModule rec {
      pname = "niri-screen-time";
      version = "1.0.0";

      src = pkgs.fetchFromGitHub {
        owner = "probeldev";
        repo = "niri-screen-time";
        rev = "main";
        sha256 = "sha256-v+yqnYYsPrA+fHfM9aIBNXpmse8K8or69BeJVyvBXyE=";
      };

      vendorHash = "sha256-9y1F2ZrmpiQJ9ZTq9SoRE2PxR65DDNCeBKf4M0HUQC4=";

      meta = with pkgs.lib; {
        description = "A utility that collects information about how much time you spend in each application";
        homepage = "https://github.com/probeldev/niri-screen-time";
        license = licenses.mit;
        platforms = platforms.linux;
      };
    })

    # Niri tweaks collection of scripts
    (pkgs.stdenv.mkDerivation rec {
      pname = "niri-tweaks";
      version = "unstable";

      src = pkgs.fetchFromGitHub {
        owner = "heyoeyo";
        repo = "niri_tweaks";
        rev = "main";
        sha256 = "sha256-igxc+14q0ub83/j3vt85r0CqpqgYE82JzZH92psNw7k=";
      };

      nativeBuildInputs = with pkgs; [makeWrapper];
      buildInputs = with pkgs; [python3 bash];

      installPhase = ''
        mkdir -p $out/bin

        # Install Python scripts with proper wrapper
        for script in *.py; do
          cp "$script" "$out/bin/"
          chmod +x "$out/bin/$script"
          wrapProgram "$out/bin/$script" --prefix PATH : ${pkgs.python3}/bin
        done

        # Install shell scripts
        for script in *.sh; do
          cp "$script" "$out/bin/"
          chmod +x "$out/bin/$script"
          wrapProgram "$out/bin/$script" --prefix PATH : ${pkgs.bash}/bin
        done
      '';

      meta = with pkgs.lib; {
        description = "A collection of scripts for enhancing Niri functionality";
        homepage = "https://github.com/heyoeyo/niri_tweaks";
        license = licenses.mit;
        platforms = platforms.linux;
      };
    })

    (pkgs.writeShellScriptBin "oguri-wallpaper" ''
            # Oguri wallpaper management
            WALLPAPER_DIR="$HOME/margotos/wallpapers"
            CONFIG_DIR="$HOME/.config/oguri"

            case "$1" in
              "static")
                if [ -z "$2" ]; then
                  echo "Usage: oguri-wallpaper static <image_path>"
                  exit 1
                fi
                mkdir -p "$CONFIG_DIR"
                cat > "$CONFIG_DIR/config" <<EOF
      [output:*]
      image=$2
      scaling-mode=fill
      EOF
                ;;
              "animated")
                if [ -z "$2" ]; then
                  echo "Usage: oguri-wallpaper animated <gif_or_video_path>"
                  exit 1
                fi
                mkdir -p "$CONFIG_DIR"
                cat > "$CONFIG_DIR/config" <<EOF
      [output:*]
      image=$2
      scaling-mode=fill
      anchor=center
      EOF
                ;;
              "random")
                if [ -d "$WALLPAPER_DIR" ]; then
                  WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.gif" -o -name "*.mp4" -o -name "*.webm" \) | shuf -n 1)
                  if [ -n "$WALLPAPER" ]; then
                    mkdir -p "$CONFIG_DIR"
                    cat > "$CONFIG_DIR/config" <<EOF
      [output:*]
      image=$WALLPAPER
      scaling-mode=fill
      anchor=center
      EOF
                    echo "Set random wallpaper: $WALLPAPER"
                  else
                    echo "No wallpapers found in $WALLPAPER_DIR"
                  fi
                else
                  echo "Wallpaper directory $WALLPAPER_DIR not found"
                fi
                ;;
              "reload")
                pkill -SIGUSR1 oguri || echo "oguri not running"
                ;;
              *)
                echo "Usage: oguri-wallpaper {static|animated|random|reload} [path]"
                echo "  static <path>   - Set static wallpaper"
                echo "  animated <path> - Set animated wallpaper (GIF/video)"
                echo "  random          - Set random wallpaper from ~/margotos/wallpapers"
                echo "  reload          - Reload oguri configuration"
                ;;
            esac
    '')

    # Skip hyprlax for now - no Cargo.lock in repo, will need manual install
    # You can install it manually with: curl -sSL https://hyprlax.com/install.sh | bash
  ];
}
