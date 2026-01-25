# Brye's NixOS

Quick install notes for this flake. Uses disko and Home Manager.

## Fresh install (NixOS ISO)

Replace `<hostname>` with the host folder under `nixos/hosts`.

```sh
sudo git clone https://github.com/bryewalks/nixos /tmp/etc/nixos

cd /tmp/etc/nixos

sudo nix run github:nix-community/disko --extra-experimental-features "nix-command flakes" -- --mode disko /tmp/etc/nixos/nixos/hosts/<hostname>/disko.nix

git add .

sudo nixos-install --flake /tmp/etc/nixos/nixos#<hostname>
```

## Notes

- The `git add .` step ensures newly generated files (like `hardware.nix`) are tracked so flakes can see them.
- Make sure the disk device in `nixos/hosts/<hostname>/disko.nix` matches the target disk.

## First boot

Use temp password (password)

Update password

```sh
passwd
```
