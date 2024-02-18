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
  time.timeZone = "Asia/Hong_Kong";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_HK.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    enable = true;

    # Enable XFCE (using as desktop manager but not as window manager, ie. install XFCE utilities for easier use) 
    # see here: (https://nixos.wiki/wiki/Xfce#Using_as_a_desktop_manager_and_not_a_window_manager)
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        # if using window manager, should use below two options
        noDesktop = true;
        enableXfwm = false;
      };
    };

    # Enable SDDM
    displayManager = {
      sddm.enable = true;
      defaultSession = "xfce+awesome";
    };

    # Enable AwesomeWM
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };

    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jamesyoung = {
    isNormalUser = true;
    description = "James Young";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Change default editor from nano to neovim
  environment.variables.EDITOR = "neovim";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # General dev utils
    curl
    git
    wget
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    pkgs.xclip
    pkgs.tldr
    pkgs.neofetch
    pkgs.xdotool
    pkgs.xbindkeys
    pkgs.pulseaudio
    pkgs.tmux

    # terminal
    pkgs.kitty
    pkgs.libsForQt5.konsole
    pkgs.alacritty
    

    # bluetooth
    pkgs.bluez

    # audio
    pkgs.pavucontrol

    # app launcher
    (rofi.override { plugins = [ rofi-emoji ]; })

    # display packages
    pkgs.picom
    pkgs.nitrogen
    pkgs.arandr
    pkgs.autorandr

    # editors
    pkgs.neovim
    pkgs.vscode
    pkgs.libsForQt5.kate

    # media players
    pkgs.vlc
    pkgs.mpv

    # browsers
    pkgs.firefox-bin
    pkgs.librewolf
    pkgs.ungoogled-chromium

    # file managers
    # pkgs.xfce.thunar

    # utilities
    pkgs.libsForQt5.kdeconnect-kde
    pkgs.gnome.gnome-disk-utility
    pkgs.lxde.lxsession
    pkgs.feh

    # gtk config
    pkgs.lxappearance
    libsForQt5.qtstyleplugin-kvantum
    pkgs.libsForQt5.qt5ct

    # gtk and qt themes
    (pkgs.catppuccin-kde.override { accents = ["lavender"]; flavour  = ["mocha"]; winDecStyles = ["modern"]; })
    (pkgs.catppuccin-gtk.override { accents = ["lavender"]; variant = "mocha"; size = "standard";  })
    pkgs.catppuccin-kvantum
    pkgs.dracula-theme
    pkgs.lightly-qt
    pkgs.libsForQt5.breeze-qt5
    pkgs.qt6Packages.qt6ct

    # cursors, icons, etc.
    pkgs.catppuccin-cursors
    pkgs.papirus-icon-theme
    (pkgs.tela-circle-icon-theme.override { colorVariants = ["dracula"]; })
    pkgs.capitaine-cursors


    # sddm customization
    pkgs.libsForQt5.sddm-kcm
    pkgs.libsForQt5.qt5.qtgraphicaleffects
    pkgs.libsForQt5.qt5.qtsvg
    pkgs.libsForQt5.qt5.qtquickcontrols2

    # applets
    pkgs.networkmanagerapplet

    # top bar
    pkgs.polybarFull


    # Games
    pkgs.cemu
    pkgs.yuzu
    pkgs.runelite
    pkgs.retroarch

    # Programming Languages
    pkgs.jdk
    pkgs.rustc
    pkgs.go
    pkgs.nodePackages_latest.nodejs

    # epub
    pkgs.calibre
    pkgs.calibre-web

    # office
    pkgs.libsForQt5.okular
    pkgs.onlyoffice-bin
    # pkgs.libreoffice-bin

    # note-taking, diagrams, etc.
    pkgs.joplin-desktop
    pkgs.drawio
    pkgs.rnote

    # graphics
    pkgs.blender
    pkgs.libresprite
    pkgs.libsForQt5.kdenlive
    pkgs.glaxnimate
    pkgs.libsForQt5.gwenview
    pkgs.obs-studio



  ];

  # file mounting permissions
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # QT Theming with KDE system settings
  qt.enable = true;
  qt.platformTheme = "kde";

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
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" "Hack" ]; })
  ];


  # Steam Setup
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

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

  # Enable Pipewire
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
