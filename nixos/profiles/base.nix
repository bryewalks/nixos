{ config, pkgs, ...}:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = false;

  time.timeZone = "America/Chicago";

  networking.networkmanager.enable = true;

  users.users.brye = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" "storage" ];
    shell = pkgs.zsh;
    initialPassword = "password"; # Replace after install with passwd command
  };

  programs.zsh.enable = true;

  security.sudo.wheelNeedsPassword = true;
  
  services.udisks2.enable = true;
  security.polkit.enable = true;
  services.openssh.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    git
    neovim
    kitty
    htop
  ];

  programs.git = {
    enable = true;
    config = {
      user.name = "bryewalks";
      user.email = "bryewalks@gmail.com";
    };
  };

  # Create /home/brye/nixos -> /etc/nixos on boot/activation.
  systemd.tmpfiles.rules = [
    "L+ /home/brye/nixos - - - - /etc/nixos"
    "d /home/brye/.ssh/ 0700 brye users -"
  ];

  system.stateVersion = "25.11";
}
