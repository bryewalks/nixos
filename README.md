# Brye's NixOS

Quick install notes for this flake. Uses disko and Home Manager.


## Fresh install (NixOS ISO)

Replace `<hostname>` with the host folder under [nixos/hosts](./nixos/hosts).

## Reformat (hardware and disko config in repo)

Format drive based on disko config and install with disko-install:
```sh
sudo nix --extra-experimental-features "nix-command flakes" \
  run "github:nix-community/disko/latest#disko-install" \
  -- --flake github:bryewalks/nixos#<hostname> \
  --disk main /dev/<disk>
```

```sh
sudo reboot
```

#### Post install

Copy sops keys to persistent storage
```sh
sudo cp /path/to/sops/keys.txt /persist/system/var/lib/sops/keys.txt
```

Rebuild
```sh
sudo nixos-rebuild switch --flake github:bryewalks/nixos#<hostname>
```

Clone NixOS repo
```sh
git clone git@github.com:bryewalks/nixos
```

## Reformat (no hardware config in repo)

Format and mount drive with disko:
```sh
sudo nix --extra-experimental-features "nix-command flakes" \
  run github:nix-community/disko \
  -- --mode destroy,format,mount \
  --flake github:bryewalks/nixos#<hostname>
```

Clone repo into mounted disk
```sh
sudo git clone https://github.com/bryewalks/nixos /mnt/tmp/nixos
```

Generate hardware config
```sh
sudo nixos-generate-config --no-filesystems \
  --show-hardware-config \
  | sudo tee /mnt/tmp/nixos/nixos/hosts/<hostname>/hardware.nix \
  > /dev/null
```

Install NixOS
```sh
sudo nixos-install --flake /mnt/tmp/nixos#<hostname>
```

* Hardware config will need to be commited at this point or regenerated post initial login.

```sh
sudo reboot
```

Continue with the [Post install](#post-install) steps.
