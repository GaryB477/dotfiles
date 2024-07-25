# Automatically sync a number of git repos

## Setup

Enable the systemd scripts. These can be found in the same folder as this script.
```sh
systemctl --user enable /home/$(whoami)/autosync/autosync-repos.timer
systemctl --user enable /home/$(whoami)/autosync/autosync-repos.service
```
This service trigger the script `/home/<user>/auto/autosync-repos.sh`, which enters a number of paths and then calls
`git-sync` -- also a script found in the same folder. 

