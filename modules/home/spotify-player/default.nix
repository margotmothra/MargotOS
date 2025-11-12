{ lib, ... }:

let
  # Get client ID from environment variable or use placeholder
  clientId = builtins.getEnv "SPOTIFY_CLIENT_ID";
  # If no env var set, use a placeholder that will fail spotify auth
  finalClientId = if clientId != "" then clientId else "REPLACE_WITH_YOUR_SPOTIFY_CLIENT_ID";
in
{
  # Spotify Player Configuration
  # Uses the built-in home-manager programs.spotify-player module
  programs.spotify-player = {
    enable = true;

    settings = {
      theme = lib.mkForce "MargotTheme";
      client_port = 8080;
      client_id = finalClientId;
      login_redirect_uri = "http://127.0.0.1:8989/login";
      playback_format = ''
{status} {track} • {artists} {liked}
{album} • {genres}
{metadata}'';
      playback_metadata_fields = [
        "repeat"
        "shuffle"
        "volume"
        "device"
      ];
      notify_timeout_in_secs = 0;
      tracks_playback_limit = 50;
      app_refresh_duration_in_ms = 32;
      playback_refresh_duration_in_ms = 0;
      page_size_in_rows = 20;
      play_icon = "▶";
      pause_icon = "▌▌";
      liked_icon = "♥";
      border_type = "Plain";
      progress_bar_type = "Rectangle";
      progress_bar_position = "Bottom";
      genre_num = 2;
      cover_img_length = 9;
      cover_img_width = 5;
      cover_img_scale = 1.0;
      enable_media_control = true;
      enable_streaming = "Always";
      enable_notify = false;
      enable_cover_image_cache = true;
      default_device = "dget";
      notify_streaming_only = false;
      seek_duration_secs = 5;
      sort_artist_albums_by_type = false;
      notify_format = {
        summary = "{track} • {artists}";
        body = "{album}";
      };
      layout = {
        playback_window_position = "Top";
        playback_window_height = 6;
        library = {
          playlist_percent = 40;
          album_percent = 40;
        };
      };
      device = {
        name = "spotify-player";
        device_type = "speaker";
        volume = 70;
        bitrate = 160;
        audio_cache = true;
        normalization = true;
        autoplay = true;
        audio_backend = "rodio";
      };
    };

    keymaps = [
      {
        command = "None";
        key_sequence = "q";
      }
    ];

    themes = [
      {
        name = "default2";
        palette = {
          black = "black";
          red = "red";
          green = "green";
          yellow = "yellow";
          blue = "blue";
          magenta = "magenta";
          cyan = "cyan";
          white = "white";
          pink = "pink";
          bright_black = "bright_black";
          bright_red = "bright_red";
          bright_green = "bright_green";
          bright_yellow = "bright_yellow";
          bright_blue = "bright_blue";
          bright_magenta = "bright_magenta";
          bright_cyan = "bright_cyan";
          bright_white = "bright_white";
        };
      }
      {
        name = "dracula";
        palette = {
          background = "#1e1f29";
          foreground = "#f8f8f2";
          black = "#000000";
          red = "#ff5555";
          green = "#50fa7b";
          yellow = "#f1fa8c";
          blue = "#bd93f9";
          magenta = "#ff79c6";
          cyan = "#8be9fd";
          white = "#bbbbbb";
          bright_black = "#555555";
          bright_red = "#ff5555";
          bright_green = "#50fa7b";
          bright_yellow = "#f1fa8c";
          bright_blue = "#bd93f9";
          bright_magenta = "#ff79c6";
          bright_cyan = "#8be9fd";
          bright_white = "#ffffff";
        };
      }
      {
        name = "MargotTheme";
        palette = {
          foreground = "#000000";
          black = "#000000";
          red = "#ff5555";
          green = "#E0C3D3";
          yellow = "#f1fa8c";
          blue = "#bd93f9";
          magenta = "#ff79c6";
          cyan = "#8be9fd";
          white = "#000000";
          bright_black = "#555555";
          bright_red = "#ff5555";
          bright_green = "#50fa7b";
          bright_yellow = "#f1fa8c";
          bright_blue = "#bd93f9";
          bright_magenta = "#ff79c6";
          bright_cyan = "#8be9fd";
          bright_white = "#000000";
        };
        component_style = {
          block_title = { fg = "Magenta"; };
          border = { fg = "Black"; };
          like = { fg = "Red"; modifiers = [ "Bold" ]; };
          selection = { bg = "Green"; fg = "Black"; modifiers = [ "Bold" ]; };
          secondary_row = { fg = "BrightBlack"; };
          playback_progress_bar = { bg = "BrightBlack"; fg = "Green"; };
          playback_track = { fg = "Green"; modifiers = [ "Bold" ]; };
          playback_status = { fg = "Green"; modifiers = [ "Bold" ]; };
          playback_artists = { fg = "Green"; modifiers = [ "Bold" ]; };
          playback_album = { fg = "Blue"; };
          playback_genres = { fg = "BrightBlack"; modifiers = [ "Italic" ]; };
          playback_metadata = { fg = "BrightBlack"; };
          current_playing = { fg = "Green"; modifiers = [ "Bold" ]; };
          page_desc = { fg = "Green"; modifiers = [ "Bold" ]; };
          playlist_desc = { fg = "BrightBlack"; modifiers = [ "Dim" ]; };
          table_header = { fg = "Green"; };
          lyrics_played = { modifiers = [ "Dim" ]; };
          lyrics_playing = { fg = "Green"; modifiers = [ "Bold" ]; };
        };
      }
      # Add more themes from your original theme.toml if needed
    ];
  };
}