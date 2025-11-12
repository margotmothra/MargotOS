{pkgs, ...}: {
  home.packages = with pkgs; [pyprland];
  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "kitty --class kitty-dropterm"
    class = "kitty-dropterm"
    size = "35% 70%"
    max_size = "3440px 100%"
    position = "150px 150px"

    [scratchpads.spotify]
    animation = "fromTop"
    command = "spotify --no-zygote"
    class = "Spotify"
    size = "80% 80%"
    float = true

    [scratchpads.spotify_player]
    animation = "fromTop"
    command = "kitty --class kitty-spotify-player -e sh -c 'spotify_player || sleep 5'"
    class = "kitty-spotify-player"
    size = "40% 70%"
    position = "10% 15%"

  '';
}
