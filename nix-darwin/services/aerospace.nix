{
  services.aerospace = {
    enable = true;
    settings = {
      after-startup-command = [
        "exec-and-forget borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=5.0"
        "layout tiles"
      ];
      exec-on-workspace-change = [
        "/bin/bash"
        "-c"
        "aeroIndicator workspace-change $AEROSPACE_FOCUSED_WORKSPACE"
      ];
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];
      key-mapping = {
        preset = "qwerty";
      };
      gaps = {
        inner = {
          vertical = 8;
          horizontal = 8;
        };
        outer = {
          top = 8;
          left = 8;
          right = 8;
          bottom = 8;
        };
      };
      mode = {
        main = {
          binding = {
            alt-slash = "layout tiles horizontal vertical";
            alt-comma = "layout accordion horizontal vertical";

            alt-h = "focus left";
            alt-j = "focus down";
            alt-k = "focus up";
            alt-l = "focus right";

            alt-shift-h = "move left";
            alt-shift-j = "move down";
            alt-shift-k = "move up";
            alt-shift-l = "move right";

            alt-shift-minus = "resize smart -50";
            alt-shift-equal = "resize smart +50";

            alt-x = "workspace-back-and-forth";
            alt-0 = "workspace 0";
            alt-1 = "workspace 1";
            alt-b = "workspace 𝙱̲rowser";
            alt-m = "workspace 𝙼̲usic";
            alt-d = "workspace 𝙳̲evelopment";
            alt-r = "workspace Te𝚛̲minal";
            alt-c = "workspace 𝙲̲ommunication";

            alt-shift-0 = ["move-node-to-workspace 0" "workspace 0"];
            alt-shift-1 = ["move-node-to-workspace 1" "workspace 1"];
            alt-shift-b = ["move-node-to-workspace 𝙱̲rowser" "workspace 𝙱̲rowser"];
            alt-shift-m = ["move-node-to-workspace 𝙼̲usic" "workspace 𝙼̲usic"];
            alt-shift-d = ["move-node-to-workspace 𝙳̲evelopment" "workspace 𝙳̲evelopment"];
            alt-shift-r = ["move-node-to-workspace Te𝚛̲minal" "workspace Te𝚛̲minal"];
            alt-shift-c = ["move-node-to-workspace 𝙲̲ommunication" "workspace 𝙲̲ommunication"];

            alt-shift-semicolon = "mode service";
          };
        };
      };
      workspace-to-monitor-force-assignment = {
        "0" = "main";
        "1" = ["secondary" "main"];
        "𝙱̲rowser" = "main";
        "Te𝚛̲minal" = "main";
        "𝙼̲usic" = ["secondary" "main"];
        "𝙳̲evelopment" = "main";
        "𝙲̲ommunication" = ["secondary" "main"];
      };
      on-window-detected = [
        {
          "if".app-id = "company.thebrowser.Browser";
          run = "move-node-to-workspace 𝙱̲rowser";
        }
        {
          "if".app-id = "com.mitchellh.ghostty";
          run = "move-node-to-workspace Te𝚛̲minal";
        }
        {
          "if".app-id = "com.apple.Music";
          run = "move-node-to-workspace 𝙼̲usic";
        }
        {
          "if".app-id = "com.microsoft.VSCodeInsiders";
          run = "move-node-to-workspace 𝙳̲evelopment";
        }
        {
          "if".app-id = "com.tinyspeck.slackmacgap";
          run = "move-node-to-workspace 𝙲̲ommunication";
        }
        {
          "if".app-id = "com.hnc.Discord";
          run = "move-node-to-workspace 𝙲̲ommunication";
        }
      ];
    };
  };
}
