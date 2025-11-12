{ config, lib, pkgs, inputs, username, ... }:

{
  # System-level xremap configuration
  services.xremap = {
    enable = true;
    withWlroots = true;  # For Wayland compositors like niri
    userName = username;  # Run as the specified user
    
    config = {
      # Global key mappings
      modmap = [
        {
          name = "caps_to_alt";
          remap = {
            "CapsLock" = "Alt_L";  # Remap Caps Lock to Left Alt
          };
        }
      ];
    };
  };
}