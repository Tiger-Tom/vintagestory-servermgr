# vintagestory-servermgr
A small collection of scripts, systemd units, and other things to facilitate running a Vintage Story server.

This was originally made for working with Arch Linux, specifically my [vintagestory-server](https://aur.archlinux.org/packages/vintagestory-server) AUR package.
The easiest way to install this is through the [vintagestory-servermgr](https://aur.archlinux.org/packages/vintagestory-servermgr) AUR package, but it could be installed manually as well.

## How to install manually:
### Required dependencies:
- mono (required to run the server itself)
- systemd (systemd unit, systemd-tmpfiles, systemd-sysusers)
### Install steps:
- Install the Vintage Story game files (either full or (recommended) server-only version) to `/usr/share/vintagestory-server/`
- Move `vintagestory-server.sysusers` to `/usr/lib/sysusers.d/vintagestory-servermgr.conf`
- Move `vintagestory-server.tmpfiles` to `/usr/lib/tmpfiles.d/vintagestory-servermgr.conf`
- Move `vintagestory-servermgr.sh` to `/usr/bin/vintagestory-servermgr`, and mark it as executable
- Move `vintagestory-server.service` to `/usr/lib/systemd/system/vintagestory-server.service`
- Move `vintagestory-server.socket` to `/usr/lib/systemd/system/vintagestory-server.socket`

## Migrate old saves
- Copy everything in the old directory to `/var/vintagestory/server-data/`
- Edit the `serverconfig.json` file and change the value of `SaveFileLocation` under `WorldConfig` to use `/var/vintagestory/server-data/Saves/...` instead of what it was previously using, and change the `ModPaths` to include `/var/vintagestory/server-data/Mods`
- Change everything under `/var/vintagestory/server-data/` to be owned by the `vintagestory-server` user and group: `chown -R vintagestory-server:vintagestory-server /var/vintagestory/server-data/*`
