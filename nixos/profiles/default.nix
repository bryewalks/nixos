{ config, pkgs, ...}:

{
  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  # Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = false;

  # Locale
  time.timeZone = "America/Chicago";

  # Networking
  networking.networkmanager.enable = true;

  # Users
  users.mutableUsers = false;
  users.users.brye = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" "storage" ];
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

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-frappe-mauve";
    wayland.enable = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    git
    neovim
    kitty
    htop
    kdePackages.dolphin
    (catppuccin-sddm.override {
	flavor = "frappe";
	accent = "mauve";
	font = "CaskaydiaCove Nerd Font Mono";
	fontSize = "12";
	loginBackground = false;
	background = "backgrounds/wall.jpg";
	userIcon = false;
    })
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
  ];

  # NixOS release compatibility
  system.stateVersion = "25.11";
}
