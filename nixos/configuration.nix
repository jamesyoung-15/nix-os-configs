# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "JamesNixDesktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # enable nix command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # setup desktop environment
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
  };
  services.displayManager.defaultSession = "plasma"; # plasma for wayland, plasmax11 for x11

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jamesyoung = {
    isNormalUser = true;
    description = "James Young";
    extraGroups = [ "networkmanager" "wheel" "docker" "storage" "audio" "jackaudio" "kvm" "dialout" "libvirtd" "openrazer"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Change default editor from nano to neovim
  environment.variables = {
    EDITOR = "nvim";
    # GDK_SCALE=2; # x11 hidpi scaling
    # GDK_DPI_SCALE=0.5; # x11 text hidpi scaling
    # STEAM_FORCE_DESKTOPUI_SCALING=2; # steam hidpi scaling
  };

  # bash setup
  programs.bash = {
    interactiveShellInit = 
      ''
      neofetch
      eval "$(starship init bash)"
      '';
    shellAliases = {
      playbongocatgif = "librewolf https://media.tenor.com/fYg91qBpDdgAAAAi/bongo-cat-transparent.gif";
      yt-dlp-mp3 = "yt-dlp --extract-audio --audio-format mp3 --audio-quality 0";
      cdprogproj = "cd ~/Programming/Programming-Projects";
      cdprogpractice = "cd ~/Programming/Programming-Practice";
    };
  };

  # automount disks
  fileSystems."/home/jamesyoung/Extra-Storage-01" = {
    device = "/dev/disk/by-label/JamesStorage";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  # keyboard
  i18n.inputMethod = {
     enable = true;
     type = "fcitx5";
     fcitx5.addons = with pkgs; [
       kdePackages.fcitx5-qt # fcitx5-gtk             # alternatively, kdePackages.fcitx5-qt
       fcitx5-chinese-addons  # table input method support
       fcitx5-nord            # a color theme
     ];
   };

  # disable wakeup trigger for amd usb controller
  services.udev.extraRules = ''
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x15b6" ATTR{power/wakeup}="disabled"
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x15b7" ATTR{power/wakeup}="disabled"
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x15b8" ATTR{power/wakeup}="disabled"
  '';

  # enable adb (Android)
  programs.adb.enable = true;


  # remove  x11 ssh ask pass gui thing: https://github.com/NixOS/nixpkgs/issues/24311
  programs.ssh.askPassword = "";

  # START list of packages
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # General dev utils
    curl
    git
    wget
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # pkgs.tldr
    pkgs.tlrc
    pkgs.tmux
    pkgs.tree
    pkgs.screen
    pkgs.gdb
    pkgs.valgrind
    pkgs.direnv
    
    # system utils
    pkgs.neofetch
    pkgs.appimage-run
    # pkgs.xdotool
    pkgs.ydotool
    pkgs.killall
    # pkgs.parcellite
    pkgs.findutils
    pkgs.starship
    pkgs.rename
    # clipboard
    pkgs.wl-clipboard-rs
    pkgs.file
    pkgs.kdePackages.dolphin-plugins

    # cli utilities
    # process monitoring
    pkgs.htop
    pkgs.btop
    pkgs.busybox
    pkgs.zip
    pkgs.p7zip
    pkgs.nix-tree
    # sensor monitoring
    pkgs.lm_sensors
    # networking
    pkgs.nmap
    pkgs.iperf
    pkgs.iperf2
    pkgs.dig
    pkgs.rclone
    pkgs.tcpdump
    pkgs.speedtest-cli
    pkgs.wireguard-tools
    # multimedia
    pkgs.feh
    pkgs.gif-for-cli
    pkgs.imagemagick
    pkgs.playerctl
    pkgs.yt-dlp
    pkgs.mediainfo
    pkgs.ffmpeg-full
    # benchmarking
    pkgs.rt-tests
    pkgs.stress-ng
    pkgs.sysbench
    pkgs.phoronix-test-suite
    # cloud
    pkgs.awscli2
    pkgs.scrcpy

    # gui utilities
    pkgs.kdePackages.kdeconnect-kde
    pkgs.gnome-disk-utility
    pkgs.piper
    pkgs.polychromatic
    # pkgs.kdePackages.ark
    pkgs.keepassxc
    pkgs.syncthing
    # pkgs.qbittorrent # had to remove b/c install error, using flatpak for now
    # pkgs.kdePackages.merkuro
    pkgs.rustdesk
    
    # Disk utilities
    # pkgs.etcher
    pkgs.mediawriter
    pkgs.rpi-imager
    pkgs.krename
    pkgs.ventoy-full
    
    # Programming Languages/Libraries
    pkgs.jdk
    pkgs.rustc
    pkgs.go
    pkgs.nodePackages_latest.nodejs
    pkgs.nodePackages.serve
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.pip
      python-pkgs.ipykernel
      python-pkgs.jupyter
      # data/ml
      python-pkgs.scipy
      python-pkgs.seaborn
      python-pkgs.numpy
      python-pkgs.pandas
      python-pkgs.matplotlib
      python-pkgs.scikit-learn
      # web scraping
      python-pkgs.selenium
      python-pkgs.beautifulsoup4
      # computer vision
      python-pkgs.pillow
      python-pkgs.opencv4
      # dev
      python-pkgs.flask
      python-pkgs.fastapi
      python-pkgs.requests
      python-pkgs.pytest
    ]))
    pkgs.jupyter
    pkgs.typescript

    # latex (using full, extremely large can use smaller if needed): https://nixos.wiki/wiki/TexLive#Installation
    pkgs.texliveFull
    pkgs.pandoc

    # Programming Tools
    pkgs.hugo
    pkgs.gh
    pkgs.act # local github actions
    pkgs.localstack # local aws stack

    # iac
    (pkgs.terraform.withPlugins(p: [
      p.archive 
      p.aws 
      p.hcloud
      p.azurerm
      p.google
      p.kubernetes
      p.helm
      p.docker
      p.cloudflare
      p.github
      p.grafana
      p.proxmox
      p.random
      p.local
      p.null
      p.time
      p.http
      p.external
      p.vault
      p.tls
    ]))
    pkgs.terraform-ls
    pkgs.vault-bin
    pkgs.pulumi-bin
    pkgs.opentofu

    # databases
    # pkgs.mysql-workbench
    pkgs.dbeaver-bin
    pkgs.sqlite

    # embedded systems tools
    pkgs.arduino
    pkgs.platformio
    pkgs.platformio-core
    # pkgs.stm32cubemx

    # stylus tablet support
    pkgs.libwacom
    pkgs.xf86_input_wacom
    pkgs.input-remapper
    pkgs.opentabletdriver

    # terminal
    pkgs.kitty
    # pkgs.kdePackages.konsole

    # audio
    pkgs.pavucontrol
    # pkgs.ocenaudio
    pkgs.tenacity
    # pkgs.audacity

    # editors
    pkgs.neovim
    pkgs.vscode
    # pkgs.kdePackages.kate

    # media players
    pkgs.vlc
    pkgs.mpv
    pkgs.clementine
    pkgs.libvlc
    pkgs.qmplay2

    # browsers
    pkgs.firefox-bin
    pkgs.librewolf
    pkgs.ungoogled-chromium

    # screenshot, webcam, etc.
    pkgs.ksnip

    # gtk and qt themes
    (pkgs.catppuccin-kde.override { accents = ["lavender"]; flavour  = ["mocha"]; winDecStyles = ["modern"]; })
    (pkgs.catppuccin-gtk.override { accents = ["lavender"]; variant = "mocha"; size = "standard";  })
    pkgs.catppuccin-kvantum
    pkgs.dracula-theme
    pkgs.lightly-qt
    # pkgs.whitesur-kde
    kdePackages.sddm-kcm # sddm theme

    # cursors, icons, etc.
    pkgs.catppuccin-cursors
    pkgs.papirus-icon-theme
    (pkgs.tela-circle-icon-theme.override { colorVariants = ["dracula" "purple"]; })
    pkgs.dracula-icon-theme
    # (pkgs.whitesur-icon-theme.override { themeVariants = ["purple" "nord"];})
    # paper-icon-theme
    pkgs.capitaine-cursors

    # Games
    pkgs.cemu
    # pkgs.yuzu # rip (can download from flatpak)
    pkgs.runelite
    pkgs.retroarch
    # pkgs.ryujinx # rip (can download from flatpak)
    pkgs.fusee-nano

    # Game Tools
    pkgs.mangohud
    pkgs.goverlay
    pkgs.lutris
    wineWowPackages.stable
    winetricks

    # epub
    pkgs.calibre
    pkgs.calibre-web

    # office
    # pkgs.kdePackages.okular
    pkgs.onlyoffice-bin
    pkgs.libreoffice
    pkgs.zoom-us

    # note-taking, diagrams, etc.
    # pkgs.joplin-desktop # using flatpak for now as version is old
    # pkgs.logseq
    pkgs.silverbullet
    pkgs.drawio
    pkgs.rnote
    pkgs.xournalpp
    pkgs.anki

    # graphics
    pkgs.blender
    pkgs.libresprite
    pkgs.kdePackages.kdenlive
    pkgs.glaxnimate
    pkgs.gimp-with-plugins
    # pkgs.kdePackages.gwenview

    # Recording
    pkgs.obs-studio
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    })
    pkgs.snapshot

    # social media
    pkgs.discord
    pkgs.signal-desktop

  ];
  # END list of packages

  # for mouse decoration on firefox/librewolf: https://discourse.nixos.org/t/firefox-does-not-use-kde-window-decorations-and-cursor/32132
  programs.dconf.enable = true;

  # file mounting permissions
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # PostgreSQL
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };

  # MySQL
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  
  # for piper
  services.ratbagd.enable = true;

  # Fonts
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    roboto
    nerdfonts
    # (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "0xProto" "RobotoMono" "JetBrainsMono" ]; })
  ];
  # ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);


  # Steam Setup
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # enable docker
  virtualisation.docker.enable = true;

  # enable virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  services.spice-vdagentd.enable = true;  # enable copy and paste between host and guest
  virtualisation.spiceUSBRedirection.enable = true; # enable usb redirection
  virtualisation.libvirtd.qemu.vhostUserPackages = [ pkgs.virtiofsd ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall = { 
    enable = false;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPorts = [51820]; # Wireguard  
  };

  # enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # services.blueman.enable = true; # only needed for WM or DE without bluetooth manager


  # Enable Pipewire (audio server), rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # open razer
  hardware.openrazer.enable = true; 

  # Enable Flatpak
  services.flatpak.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}