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
 #  services.displayManager.sddm.enable = true;
  
  services.xserver = {
    enable = true;

    # Enable LightDM
     displayManager = {
       lightdm.enable = true;
       lightdm.greeters.gtk.enable = true;
       lightdm.greeters.gtk.theme.name = "Catppuccin-Mocha-Standard-Lavender-Dark";
       lightdm.greeters.gtk.iconTheme.name = "Papirus";
       lightdm.greeters.gtk.cursorTheme.name = "Capitaine";
    #  # lightdm.background = /home/jamesyoung/Pictures/Wallpapers/PurpleMoon-Wallpaper.jpg;
    #   defaultSession = "plasma";
     };

    # wacom.enable = true;
  };

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
  environment.variables.EDITOR = "nvim";

  # bash setup
  programs.bash = {
    interactiveShellInit = 
      ''
      neofetch
      eval "$(starship init bash)"
      '';
    shellAliases = {
      playbongocatgif = "librewolf https://media.tenor.com/fYg91qBpDdgAAAAi/bongo-cat-transparent.gif";
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
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      libpinyin
      uniemoji
        
    ];
  };

  # enable adb (Android)
  programs.adb.enable = true;


  # remove  x11 ssh ask pass gui thing: https://github.com/NixOS/nixpkgs/issues/24311
  programs.ssh.askPassword = "";


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

    # cli utilities
    # process monitoring
    pkgs.htop
    pkgs.btop
    pkgs.busybox
    pkgs.zip
    pkgs.nix-tree
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
    pkgs.mp3info
    # cloud
    pkgs.awscli2

    # gui utilities
    pkgs.kdePackages.kdeconnect-kde
    pkgs.gnome.gnome-disk-utility
    pkgs.piper
    pkgs.polychromatic
    # pkgs.kdePackages.ark
    pkgs.keepassxc
    pkgs.syncthing
    # pkgs.qbittorrent
    pkgs.qbittorrent
    # pkgs.kdePackages.merkuro
    # pkgs.etcher
    pkgs.rpi-imager
    pkgs.krename
    
    

    # Programming Languages
    pkgs.jdk
    pkgs.rustc
    pkgs.go
    pkgs.nodePackages_latest.nodejs
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.pip
      python-pkgs.flask
      python-pkgs.numpy
      python-pkgs.fastapi
      python-pkgs.pandas
      python-pkgs.requests
      python-pkgs.ipykernel
      python-pkgs.matplotlib
      python-pkgs.jupyter
      python-pkgs.pillow
      python-pkgs.pytest
      python-pkgs.selenium
    ]))
    pkgs.jupyter

    # latex (using full, extremely large can use smaller if needed): https://nixos.wiki/wiki/TexLive#Installation
    pkgs.texliveFull
    pkgs.pandoc

    # Programming Tools
    pkgs.hugo

    # containerization
    # pkgs.minikube
    # pkgs.k3s
    # pkgs.kubernetes
    # pkgs.faas-cli
    # pkgs.kubernetes-helm
    # pkgs.arkade

    # storage/databases
    # pkgs.minio
    # pkgs.minio-client

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
    
    # bluetooth
    # pkgs.bluez
    # pkgs.libsForQt5.bluedevil

    # audio
    # pkgs.pulseaudio
    pkgs.pavucontrol
    # pkgs.ocenaudio
    pkgs.tenacity
    # pkgs.audacity
    # pkgs.alsa-utils
    # pkgs.pamixer

    # rofi (launcher)
    # (rofi.override { plugins = [ 
    #   rofi-emoji
    #   rofi-power-menu
    #   rofi-calc
    #   rofi-screenshot
    #   rofi-file-browser
    # ]; })

    # display packages
    # pkgs.picom
    # pkgs.nitrogen
    # pkgs.arandr
    # pkgs.autorandr

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
    # pkgs.libsForQt5.spectacle
    pkgs.ksnip

    # gtk config
    # pkgs.lxappearance
    # libsForQt5.qtstyleplugin-kvantum
    # pkgs.libsForQt5.qt5ct

    # gtk and qt themes
    (pkgs.catppuccin-kde.override { accents = ["lavender"]; flavour  = ["mocha"]; winDecStyles = ["modern"]; })
    (pkgs.catppuccin-gtk.override { accents = ["lavender"]; variant = "mocha"; size = "standard";  })
    pkgs.catppuccin-kvantum
    pkgs.dracula-theme
    pkgs.lightly-qt
    # pkgs.whitesur-kde

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
    # pkgs.libreoffice-bin
    pkgs.zoom-us

    # note-taking, diagrams, etc.
    # pkgs.joplin-desktop
    # pkgs.silverbullet
    pkgs.drawio
    pkgs.rnote
    pkgs.xournalpp
    pkgs.anki

    # graphics
    pkgs.blender
    pkgs.libresprite
    pkgs.kdePackages.kdenlive
    pkgs.glaxnimate
    # pkgs.kdePackages.gwenview
    pkgs.obs-studio
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    })
    pkgs.gimp-with-plugins

    # social media
    pkgs.discord
    pkgs.signal-desktop-beta

  

  ];

  # enable thunar plugins
  # programs.thunar.plugins = with pkgs.xfce; [
  #   thunar-archive-plugin
  #   thunar-volman
  #   thunar-media-tags-plugin
  # ];

  # for mouse decoration on firefox/librewolf: https://discourse.nixos.org/t/firefox-does-not-use-kde-window-decorations-and-cursor/32132
  programs.dconf.enable = true;

  # file mounting permissions
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;


  # Fonts
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    roboto
    nerdfonts
    # (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" "Hack" ]; })
  ];


  # Steam Setup
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # enable docker
  virtualisation.docker.enable = true;

  # enable virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  services.spice-vdagentd.enable = true;  # enable copy and paste between host and guest

  # enable virtualbox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.draganddrop = true;
  users.extraGroups.vboxusers.members = [ "jamesyoung" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  
  # pipewire bluetooth support
  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };

  # open razer
  hardware.openrazer.enable = true; 

  # enable gnome keyring
  # services.gnome.gnome-keyring.enable = true;

  # Enable XDG Portal
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  xdg.portal.config.common.default = "*";
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];

  };
  # xdg.portal.enable = true;


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
