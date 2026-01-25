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
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  security.sudo.wheelNeedsPassword = true;

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

  system.stateVersion = "25.11";
}
