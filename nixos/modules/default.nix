{ config, pkgs, ... }:

{
  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  # Bootloader
  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
    loader.grub.enable = false;
    loader.timeout = 0; # Hold space to access NixOS Selection screen
  };

  # Locale
  time.timeZone = "America/Chicago";

  # Networking
  networking.networkmanager.enable = true;

  # Users
  users.mutableUsers = false;
  users.users.brye = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "networkmanager" "video" "audio" "input" "storage" "docker" ];
    shell = pkgs.zsh;
    initialPassword = "password"; # Replace with passwd or sops
  };

  # Programs
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/brye/nixos";
  };

  # Gaming
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  environment.etc."chromium/policies/managed/managed_policies.json".text =
    builtins.toJSON {
      PasswordManagerEnabled = false;
      CredentialsEnableService = false;
      PasswordLeakDetectionEnabled = false;
    };

  # Security
  security.sudo = {
    wheelNeedsPassword = true;
    extraConfig = ''
      Defaults lecture = never
    '';
  };
  security.polkit.enable = true;
  security.rtkit.enable = true;

  # Services
  services.udisks2.enable = true;
  services.openssh.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  virtualisation.docker.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    git
    neovim
    nh
    kitty
    docker-compose
    lshw
  ];

  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];

  # NixOS release compatibility
  system.stateVersion = "25.11";
}
