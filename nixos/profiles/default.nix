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
    initrd.verbose = false;
    initrd.systemd.enable = true;
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "splash"
      "intremap=on"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    plymouth.enable = true;
    plymouth.logo =
      "${pkgs.nixos-icons}/share/icons/hicolor/128x128/apps/nix-snowflake.png";
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
      [ "wheel" "networkmanager" "video" "audio" "input" "storage" ];
    shell = pkgs.zsh;
    initialPassword = "password"; # Replace with passwd or sops
  };

  # Programs
  programs.zsh.enable = true;
  programs.git.enable = true;

  # Security
  security.sudo.wheelNeedsPassword = true;
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

  # System packages
  environment.systemPackages = with pkgs; [
    git
    neovim
    kitty
    btop
    kdePackages.dolphin
  ];

  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];

  # NixOS release compatibility
  system.stateVersion = "25.11";
}
