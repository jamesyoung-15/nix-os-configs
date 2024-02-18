# My NixOS Configs
My desktop (and later laptop) config files. Ongoing transitioning from Arch + KDE (see old configs [here]()) to NixOS + AwesomeWM.

## Preview
Todo

## System Info
- OS: NixOS
- Window Manager: AwesomeWM ([XFCE as Desktop Manager](https://nixos.wiki/wiki/Xfce#Using_as_a_desktop_manager_and_not_a_window_manager))
- Shell: Bash
- Terminal: [kitty](https://github.com/kovidgoyal/kitty)
- Application Launcher: Rofi
- File Manager: [Thundar](https://nixos.wiki/wiki/Thunar)
- Topbar: [Wibar](https://awesomewm.org/doc/api/classes/awful.wibar.html)
- GTK Themes: [Catppuccin GTK](https://github.com/catppuccin/gtk)
- Plasma Themes:
    - Global Theme: Dracula
    - Colors: Catppuccin Mocha Mauve
    - Plasma Style: ChromeOS
    - Application Style: Breeze
    - Window Decorations: Scratchy
    - Fonts: Mono Nerd Font Mono 10 pt
    - Icons: Tela Circle Dark
    - Cursor: Dracula Cursor


## System Setup
Todo

## Application List
### My Other Commonly Used Applications (GUI)
- GTK Themes Editing: lxappearance
- QT Themes Editing: KDE settings
- Video Player: VLC, MPV
- Browsers: Librewolf, Ungoogle Chromium
- Text-Editors: Kate, NVIM
- IDE: VSCode
- PDF Viewer: Okular
- Image Viewer: Gwenview
- Gaming
  - Launchers: Steam, Lutris
  - Emulators: Yuzu (Switch), Cemu (Wii)
- Graphics: 
  - 3D: Blender
  - Photo Editing: GIMP
  - Video Editing: KdenLive
- ePub: Calibre
- Note-taking:
  - General: Joplin
  - Drawing: R-Note (stylus), Excalidraw
  - Diagrams: DrawIO, Excalidraw
- Printing: CUPS
- USB flashing: Balena Etcher

### Some Extra CLI Applications I use
- neofetch (display system info)
- tldr (simplify man pages)
- tmux (terminal multiplexer)
- xdotool (automate key presses, useful in scripts eg. see my automatic playing MarioKart64 in my deep reinforcement learning project [DeepKart64](https://github.com/jamesyoung-15/DeepQLKart64/))
- htop (top but a little nicer)
- yt-dlp (CLI youtube audio/video downloader, super useful)
- vim 
- neovim

## Next Steps
- Familiarize using Window Manager instead of DE (tiling, using keyboard more than mouse, etc.)
- Modularize NixOS config file instead of one large config file
- Improve AwesomeWM configs
  - Improve and style topbar
  - Maybe add bottom dock
  - Personalize behaviour more in general