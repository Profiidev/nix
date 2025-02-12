# Nix Config

# Remote Install

1. Set root password on target machine (with nixos installer iso running)
2. Run `remote.sh` with the target ip
   ```
   ./remote.sh <config_name> <ip>
   ```

# Installer Image

Build installer image with `build.sh` result will be in `result/iso`
```
./build.sh <config_name>
```
