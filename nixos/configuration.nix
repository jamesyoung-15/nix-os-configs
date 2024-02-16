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

  networking.hostName = "JamesDesktop"; # Define your hostname.
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
   
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        # noDesktop = true;
        # enableXfwm = false;
      };
    };
    
    # using sddm
    displayManager = {
      sddm.enable = true;
      defaultSession = "xfce";
    };

    # enable awesomewm
    windowManager.awesome = {
      enable = false;
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
  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # general dev utils
    curl
    git
    wget
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    pkgs.xclip
    # others
    # pkgs.rofi
    (rofi.override { plugins = [ rofi-emoji ]; })
    pkgs.picom
    pkgs.nitrogen
    pkgs.arandr
    pkgs.neovim
    pkgs.tldr
    pkgs.neofetch
    pkgs.kitty
    pkgs.vlc
    pkgs.mpv
    pkgs.firefox-bin
    pkgs.librewolf
    pkgs.ungoogled-chromium
    pkgs.xfce.thunar
    pkgs.vscode
    pkgs.libsForQt5.kate
    pkgs.libsForQt5.kdeconnect-kde
    pkgs.pavucontrol
    pkgs.lxappearance
    (pkgs.catppuccin-kde.override { accents = ["lavender"]; flavour  = ["mocha"]; winDecStyles = ["modern"]; })
    (pkgs.catppuccin-gtk.override { accents = ["lavender"]; variant = "mocha"; size = "standard";  })
    pkgs.catppuccin-cursors
    pkgs.papirus-icon-theme
    pkgs.capitaine-cursors
    libsForQt5.qtstyleplugin-kvantum
    # pkgs.autorandr
  ];
  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "gtk2"; 
  };
  environment.variables.QT_QPA_PLATFORMTHEME = "gtk2";

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
