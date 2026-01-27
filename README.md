# Brye's NixOS

Quick install notes for this flake. Uses disko and Home Manager.


## Fresh install (NixOS ISO)

Replace `<hostname>` with the host folder under `nixos/hosts`.

### Format drive using disko
```sh
sudo nix --extra-experimental-features "nix-command flakes" \
  run github:nix-community/disko \
  -- --mode destroy,format,mount \
  --flake github:bryewalks/nixos#<hostname>
```
* Make sure the disk device in `nixos/hosts/<hostname>/disko.nix` matches the target disk.

### Clone repo into mounted disk
```sh
sudo git clone https://github.com/bryewalks/nixos /mnt/etc/nixos \
  && git config --global --add safe.directory /mnt/etc/nixos
```

### Generate hardware config
* Skip straight to install nixos if hardware config already exists in repo.
 
```sh
sudo nixos-generate-config --no-filesystems \
  --show-hardware-config \
  | sudo tee /mnt/etc/nixos/nixos/hosts/<hostname>/hardware.nix \
  > /dev/null
```

```sh
sudo git -C /mnt/etc/nixos add .
```

### Install NixOS
```sh
sudo nixos-install --flake \
  /mnt/etc/nixos/nixos#<hostname>
```

### Reboot
```sh
sudo reboot
```

## First boot

###
Use temp password
```sh
password: password
```

###
Update password

```sh
passwd
```



## Reformat (hardware and disko config exists in repo)

Format drive using disko config and install NixOS in one step:
```sh
sudo nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko -- \
  disko-install --flake github:bryewalks/nixos#<hostname>
```

sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --flake github:bryewalks/nixos\#<hostname> --disk main /dev/<disk>

Add sops decryption key:
```sh
sudo mkdir /mnt/persist/sops/
sudo cp /path/to/sops/keys.txt /mnt/persist/system/var/libs/sops/keys.txt 
```


