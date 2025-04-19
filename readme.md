# wavy-bacon

wavy-bacon is two things:

1. A containerized Minecraft server platform
2. A Minecraft server running at `wavy-bacon.bingecraft.net`

## prerequisites

1. [git](https://git-scm.com/)
2. [podman](https://podman.io/)
3. create a `backups/` folder or symlink next to `Containerfile`

## usage

1. download the server platform: `git clone https://github.com/bingecraft-net/wavy-bacon`
2. build and start the server: `commands/start`
   - the server will be exposed on host ports defined in `commands/start`
3. generate a backup: `commands/backup`
   - backups are saved to the `backups/` folder
4. stop the server: `commands/stop`
   - resume the server: `commands/start`
5. update the server platform: `git pull`
6. stop and remove the server: `commands/destroy`
   - `backups/` will be left intact
