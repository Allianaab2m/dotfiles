{ ... }:
{
  home.file.".aerospace.toml".text = ''
    # Start aerospace at login
    start-at-login = true

    after-startup-command = [
      'exec-and-forget borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=5.0',
      'exec-and-forget aeroIndicator --restart-service',
      'layout tiles'
    ]

    # Notify Sketchybar about workspace change
    exec-on-workspace-change = [
      '/bin/bash',
      '-c',
      'aeroIndicator workspace-change $AEROSPACE_FOCUSED_WORKSPACE'
    ]

    on-focus-changed = [
      'exec-and-forget aeroIndicator focus-change',
    ]

    enable-normalization-flatten-containers = true
    enable-normalization-opposite-orientation-for-nested-containers = true

    accordion-padding = 30

    default-root-container-layout = 'tiles'
    default-root-container-orientation = 'auto'

    on-focused-monitor-changed = ['move-mouse monitor-lazy-center']

    [key-mapping]
    preset = 'qwerty'

    [gaps]
    inner.vertical = 8 
    inner.horizontal = 8 
    outer.top = 8
    outer.left = 8
    outer.right = 8
    outer.bottom = 8

    [mode.main.binding]

    # Change split layout
    alt-slash = 'layout tiles horizontal vertical'
    alt-comma = 'layout accordion horizontal vertical'

    # Terminal
    alt-enter = 'exec-and-forget osascript -e "tell application \\"Ghossty\\" to run'
    alt-t = 'exec-and-forget open -n /Users/alliana/Applications/Home Manager Apps/Alacritty.app'

    # Window Focus
    alt-h = 'focus left'
    alt-j = 'focus down'
    alt-k = 'focus up'
    alt-l = 'focus right'

    # Window Move
    alt-shift-h = 'move left'
    alt-shift-j = 'move down'
    alt-shift-k = 'move up'
    alt-shift-l = 'move right'

    # Window Resize
    alt-shift-minus = 'resize smart -50'
    alt-shift-equal = 'resize smart +50'

    # Switch workspaces
    # alt-2 = 'workspace 2'
    # alt-3 = 'workspace 3'
    # alt-4 = 'workspace 4'
    # alt-5 = 'workspace 5'
    # alt-6 = 'workspace 6'
    # alt-7 = 'workspace 7'
    # alt-8 = 'workspace 8'
    # alt-9 = 'workspace 9'
    alt-x = 'workspace-back-and-forth'

    alt-0 = 'workspace 0'
    alt-1 = 'workspace 1'
    alt-b = 'workspace 𝙱̲rowser'
    alt-m = 'workspace 𝙼̲usic'
    alt-d = 'workspace 𝙳̲evelopment' 
    alt-r = 'workspace Te𝚛̲minal'
    alt-c = 'workspace 𝙲̲ommunication'


    # Window move to workspaces
    # alt-shift-2 = 'move-node-to-workspace 2'
    # alt-shift-3 = 'move-node-to-workspace 3'
    # alt-shift-4 = 'move-node-to-workspace 4'
    # alt-shift-5 = 'move-node-to-workspace 5'
    # alt-shift-6 = 'move-node-to-workspace 6'
    # alt-shift-7 = 'move-node-to-workspace 7'
    # alt-shift-8 = 'move-node-to-workspace 8'
    # alt-shift-9 = 'move-node-to-workspace 9'
    alt-shift-0 = ['move-node-to-workspace 0', 'workspace 0']
    alt-shift-1 = ['move-node-to-workspace 1', 'workspace 1']
    alt-shift-b = ['move-node-to-workspace 𝙱̲rowser', 'workspace 𝙱̲rowser']
    alt-shift-m = ['move-node-to-workspace 𝙼̲usic', 'workspace 𝙼̲usic']
    alt-shift-d = ['move-node-to-workspace 𝙳̲evelopment', 'workspace 𝙳̲evelopment']
    alt-shift-r = ['move-node-to-workspace Te𝚛̲minal', 'workspace Te𝚛̲minal']
    alt-shift-c = ['move-node-to-workspace 𝙲̲ommunication', 'workspace 𝙲̲ommunication']

    # Mode service
    alt-shift-semicolon = 'mode service'

    # workspace assignment
    [workspace-to-monitor-force-assignment]
    0 = 'main'
    1 = ['secondary', 'main']
    '𝙱̲rowser' = 'main'
    'Te𝚛̲minal' = 'main'
    '𝙼̲usic' = ['secondary', 'main']
    '𝙳̲evelopment' = 'main'
    '𝙲̲ommunication' = ['secondary', 'main']

    [mode.service.binding]
    esc = ['reload-config', 'mode main']
    r = ['flatten-workspace-tree', 'mode main'] # reset layout
    f = ['layout floating tiling', 'mode main'] # Toggle between floating and tiling layout
    backspace = ['close-all-windows-but-current', 'mode main']

    h = ['join-with left', 'mode main']
    j = ['join-with down', 'mode main']
    k = ['join-with up', 'mode main']
    l = ['join-with right', 'mode main']

    [[on-window-detected]]
    if.app-id = 'company.thebrowser.Browser'
    run = 'move-node-to-workspace 𝙱̲rowser'

    [[on-window-detected]]
    if.app-id = 'com.mitchellh.ghostty'
    run = 'move-node-to-workspace Te𝚛̲minal'

    [[on-window-detected]]
    if.app-id = 'com.apple.Music'
    run = 'move-node-to-workspace 𝙼̲usic' 

    [[on-window-detected]]
    if.app-id = 'com.microsoft.VSCodeInsiders'
    run = 'move-node-to-workspace 𝙳̲evelopment'

    [[on-window-detected]]
    if.app-id = 'com.tinyspeck.slackmacgap'
    run = 'move-node-to-workspace 𝙲̲ommunication'

    [[on-window-detected]]
    if.app-id = 'com.hnc.Discord'
    run = 'move-node-to-workspace 𝙲̲ommunication'
  '';
}
