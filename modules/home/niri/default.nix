{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./niri.nix
    ./binds.nix
    ./wallpaper.nix
  ];

  # Install packages
  home.packages = with pkgs; [
    inputs.dgop.packages.${pkgs.system}.default  # Keep system monitoring
  ];

  # Keep swaybg killer since stylix might still use it
  systemd.user.services.kill-swaybg = {
    Unit = {
      Description = "Kill swaybg to prevent wallpaper conflicts with swww";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.procps}/bin/pkill swaybg || true";
      RemainAfterExit = false;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # DMS removed - using clean niri + swww setup

}
