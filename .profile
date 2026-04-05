# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH:/home/linuxbrew/.linuxbrew/bin/"

export EDITOR=/home/linuxbrew/.linuxbrew/bin//nvim

export _JAVA_AWT_WM_NONREPARENTING=1
export ELECTRON_FORCE_DEVICE_SCALE_FACTOR=1.2

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
