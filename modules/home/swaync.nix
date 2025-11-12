{ config, ... }: {
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = false;
      control-center-width = 500;
      control-center-height = 1025;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
      widget-config = {
        title = {
          text = "Notification Center";
          clear-all-button = true;
          button-text = "󰆴 Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 1;
          text = "Notification Center";
        };
        mpris = {
          image-size = 96;
          image-radius = 7;
        };
        volume = {
          label = "󰕾";
        };
        backlight = {
          label = "󰃟";
        };
      };
      widgets = [
        "title"
        "mpris"
        "volume"
        "backlight"
        "dnd"
        "notifications"
      ];
    };
    style = ''
      * {
        font-family: Maple Mono;
        font-weight: 500;
      }
      .control-center .notification-row:focus,
      .control-center .notification-row:hover {
        opacity: 0.95;
        background: rgba(255, 255, 255, 0.1);
      }
      .notification-row {
        outline: none;
        margin: 8px;
        padding: 0;
      }
      .notification {
        background: transparent;
        padding: 0;
        margin: 0px;
      }
      .notification-content {
        background: rgba(255, 255, 255, 0.85);
        padding: 12px;
        border-radius: 12px;
        border: 1px solid rgba(255, 255, 255, 0.3);
        margin: 0;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
      }
      .notification-default-action {
        margin: 0;
        padding: 0;
        border-radius: 12px;
      }
      .close-button {
        background: rgba(0, 0, 0, 0.1);
        color: rgba(0, 0, 0, 0.7);
        text-shadow: none;
        padding: 4px;
        border-radius: 8px;
        margin-top: 8px;
        margin-right: 8px;
        border: none;
      }
      .close-button:hover {
        box-shadow: none;
        background: rgba(0, 0, 0, 0.2);
        transition: all .2s ease-in-out;
        border: none;
        color: rgba(0, 0, 0, 0.9);
      }
      .notification-action {
        border: 1px solid rgba(0, 0, 0, 0.1);
        border-top: none;
        border-radius: 8px;
        background: rgba(255, 255, 255, 0.3);
      }
      .notification-default-action:hover,
      .notification-action:hover {
        color: rgba(0, 0, 0, 0.9);
        background: rgba(255, 255, 255, 0.5);
      }
      .notification-default-action {
        border-radius: 12px;
        margin: 0px;
      }
      .notification-default-action:not(:only-child) {
        border-bottom-left-radius: 8px;
        border-bottom-right-radius: 8px;
      }
      .notification-action:first-child {
        border-bottom-left-radius: 8px;
        background: rgba(255, 255, 255, 0.3);
      }
      .notification-action:last-child {
        border-bottom-right-radius: 8px;
        background: rgba(255, 255, 255, 0.3);
      }
      .inline-reply {
        margin-top: 8px
      }
      .inline-reply-entry {
        background: #${config.lib.stylix.colors.base00};
        color: #${config.lib.stylix.colors.base05};
        caret-color: #${config.lib.stylix.colors.base05};
        border: 1px solid #${config.lib.stylix.colors.base09};
        border-radius: 5px
      }
      .inline-reply-button {
        margin-left: 4px;
        background: #${config.lib.stylix.colors.base00};
        border: 1px solid #${config.lib.stylix.colors.base09};
        border-radius: 5px;
        color: #${config.lib.stylix.colors.base05}
      }
      .inline-reply-button:disabled {
        background: initial;
        color: #${config.lib.stylix.colors.base03};
        border: 1px solid transparent
      }
      .inline-reply-button:hover {
        background: #${config.lib.stylix.colors.base00}
      }
      .body-image {
        margin-top: 6px;
        background-color: #${config.lib.stylix.colors.base05};
        border-radius: 5px
      }
      .summary {
        font-size: 16px;
        font-weight: 600;
        background: transparent;
        color: rgba(0, 0, 0, 0.9);
        text-shadow: none;
      }
      .time {
        font-size: 14px;
        font-weight: 500;
        background: transparent;
        color: rgba(0, 0, 0, 0.6);
        text-shadow: none;
        margin-right: 18px;
      }
      .body {
        font-size: 14px;
        font-weight: 400;
        background: transparent;
        color: rgba(0, 0, 0, 0.8);
        text-shadow: none;
      }
      .control-center {
        background: rgba(255, 255, 255, 0.8);
        border: 1px solid rgba(255, 255, 255, 0.4);
        border-radius: 16px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
      }
      .control-center-list {
        background: transparent;
      }
      .control-center-list-placeholder {
        opacity: 0.4;
        color: rgba(0, 0, 0, 0.5);
      }
      .floating-notifications {
        background: transparent;
      }
      .blank-window {
        background: alpha(black, 0);
      }
      .widget-title {
        color: rgba(0, 0, 0, 0.9);
        background: rgba(255, 255, 255, 0.3);
        padding: 8px 14px;
        margin: 12px 12px 8px 12px;
        font-size: 1.4rem;
        font-weight: 600;
        border-radius: 10px;
        border: 1px solid rgba(255, 255, 255, 0.2);
      }
      .widget-title>button {
        font-size: 0.9rem;
        color: rgba(0, 0, 0, 0.7);
        text-shadow: none;
        background: rgba(255, 255, 255, 0.4);
        box-shadow: none;
        border-radius: 8px;
        border: 1px solid rgba(255, 255, 255, 0.3);
      }
      .widget-title>button:hover {
        background: rgba(0, 0, 0, 0.1);
        color: rgba(0, 0, 0, 0.9);
      }
      .widget-dnd {
        background: rgba(255, 255, 255, 0.3);
        padding: 8px 14px;
        margin: 12px 12px 8px 12px;
        border-radius: 10px;
        font-size: large;
        color: rgba(0, 0, 0, 0.8);
        border: 1px solid rgba(255, 255, 255, 0.2);
      }
      .widget-dnd>switch {
        border-radius: 15px;
        background: rgba(0, 0, 0, 0.2);
      }
      .widget-dnd>switch:checked {
        background: rgba(52, 152, 219, 0.8);
        border: 1px solid rgba(52, 152, 219, 0.3);
      }
      .widget-dnd>switch slider {
        background: rgba(255, 255, 255, 0.9);
        border-radius: 50%;
      }
      .widget-dnd>switch:checked slider {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 50%;
      }
      .widget-label {
          margin: 10px 10px 5px 10px;
      }
      .widget-label>label {
        font-size: 1rem;
        color: #${config.lib.stylix.colors.base05};
      }
      .widget-mpris {
        color: #${config.lib.stylix.colors.base05};
        padding: 5px 10px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
      }
      .widget-mpris > box > button {
        border-radius: 5px;
      }
      .widget-mpris-player {
        padding: 5px 10px;
        margin: 10px
      }
      .widget-mpris-title {
        font-weight: 700;
        font-size: 1.25rem
      }
      .widget-mpris-subtitle {
        font-size: 1.1rem
      }
      .widget-menubar>box>.menu-button-bar>button {
        border: none;
        background: transparent
      }
      .topbar-buttons>button {
        border: none;
        background: transparent
      }
      .widget-volume {
        background: rgba(255, 255, 255, 0.3);
        padding: 8px 12px;
        margin: 12px 12px 8px 12px;
        border-radius: 10px;
        font-size: x-large;
        color: rgba(0, 0, 0, 0.8);
        border: 1px solid rgba(255, 255, 255, 0.2);
      }
      .widget-volume>box>button {
        background: rgba(0, 0, 0, 0.1);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 8px;
        color: rgba(0, 0, 0, 0.7);
      }
      .per-app-volume {
        background-color: rgba(255, 255, 255, 0.2);
        padding: 6px 10px 10px;
        margin: 0 10px 10px;
        border-radius: 8px;
        border: 1px solid rgba(255, 255, 255, 0.1);
      }
      .widget-backlight {
        background: rgba(255, 255, 255, 0.3);
        padding: 8px 12px;
        margin: 12px 12px 8px 12px;
        border-radius: 10px;
        font-size: x-large;
        color: rgba(0, 0, 0, 0.8);
        border: 1px solid rgba(255, 255, 255, 0.2);
      }
    '';
  };
}
