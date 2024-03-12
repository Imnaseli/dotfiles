## Useful Commands

```sh
iwevent
```
Run this command to watch what the Wifi hardware is doing. Pay attention to the disconnect reasons, and ignore the scans.

```sh
sudo systemctl restart NetworkManager
```

This command will restart the service that manages all Internet traffic on the computer, which is usually easier than restarting the computer

-------------------------------------------------------------------------------------------------------------------------------------------------------

the command i use to create the symlink is
- assuming we want to create a symlink for neofetch from the ~/.config folder to the .dots folder
``` bash

    ln -s ~/.dots/bin ~/

``
- move the configuration file/folder to the dot folder
- create the symlink from the dot folder to the ~/.config folder or where it is meant to be

#### for neofetch the complete commands from the home directory were 

```
    mv ./.config/neofetch ./.dots 
    ln -s ~/.dots/neofetch  ~/.config
``

#### to check the wifi driver i use
```
lspci -k | grep -i network -A 2
```
