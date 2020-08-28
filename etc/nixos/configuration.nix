# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./filesystems.nix
    ];

  #### Boot configuration ####

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    # Use the latest available linux kernel. I like to live dangerously!
    kernelPackages = pkgs.linuxPackages_latest;
  };
  
  #### Networking Configuration ####
  
  networking = {
    hostName = "noctis"; # Define your hostname.
    hostId = "FADEFACE";
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;  

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces = {
      enp5s0.useDHCP = true;
      wlp4s0.useDHCP = true;
    };

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  #### Programs & Packages ####

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; let
    unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
  in [
    wget 
    vim
    ddate
    testdisk
    git
    nano
    networkmanager
    networkmanagerapplet
    openssh
    bluedevil
    bluez
    firefox-devedition-bin
    unstable.openrgb
    kdeApplications.spectacle
    tailscale
  ];

  # Enable ZSH completion for system packages
  environment.pathsToLink = [ "/share/zsh" ];

  programs = {
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    mtr.enable = true;
    zsh.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    #   pinentryFlavor = "gnome3";
    # }
  };

  # fonts.fonts = with pkgs; [ roboto ];

  #### Services ####

  services = { 
    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      forwardX11 = true;
    }; 

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      layout = "us";
      # xkbOptions = "eurosign:e";

      # Enable touchpad support.
      # libinput.enable = true;

      # Enable the KDE Desktop Environment.
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };

    udev.extraRules = ''
      # Rule for the Ergodox EZ Original / Shine / Glow
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", TAG+="uaccess"
      # Rule for the Planck EZ Standard / Glow
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", TAG+="uaccess"
    '';

    tailscale.enable = true;
  };

  # Enable the Docker daemon.
  virtualisation.docker = {
    enable = true;
    # Docker appears to select `devicemapper` by default, which is not cool.
    storageDriver = "overlay2";
    # Prune the docker registry weekly.
    autoPrune.enable = true;
  };

  #### Hardware ####

  hardware.bluetooth.enable = true;

  # needed by steam
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.driSupport32Bit = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eliza = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel" # Enable ‘sudo’ for the user. 
      "networkmanager" 
      "audio"
      "docker" # Enable docker.
    ];
    shell = pkgs.zsh; 
    openssh.authorizedKeys.keyFiles = [ "/home/eliza/.ssh/butterfly.id_ed25519.pub" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  nixpkgs.config.allowUnfree = true;
}

