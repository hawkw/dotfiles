{ config, lib, pkgs, ... }:

{

  #### Boot configuration ####

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Use the latest available linux kernel. I like to live dangerously!
    kernelPackages = pkgs.linuxPackages_5_8;
  };

  #### Networking Configuration ####

  networking = {
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
  environment.systemPackages = with pkgs;
    let unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
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
      tailscale
    ];

  programs = {
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    mtr.enable = true;
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
    extraOptions = ''
      --experimental
    '';
  };

  #### Hardware ####

  hardware = { bluetooth.enable = true; };

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
      "wireshark" # of course i want to be in the wireshark group!
    ];
    shell = pkgs.zsh;
    #   openssh.authorizedKeys.keyFiles =
    #      [ "/home/eliza/.ssh/butterfly.id_ed25519.pub" ];
  };

  nixpkgs.config.allowUnfree = true;
}
