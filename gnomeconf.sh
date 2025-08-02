#!/bin/bash -e

# Messages en couleur
error()    { echo -e "\033[0;31m====> $*\033[0m" ;}
message()  { echo -e "\033[0;32m====> $*\033[0m" ;}
warning()  { echo ; echo -e "\033[0;33m====> $*\033[0m" ;}

# Chargement du fichier de config
dist=$(grep "^ID=" /etc/os-release | cut -d= -f2,2 | tr -d '"')
cfg="$(dirname "$0")/config/$dist.cfg"
if [[ ! -f $cfg ]]; then
  error "Fichier $cfg introuvable"
  exit 1
else
  . $cfg
fi

# Exécution
warning "Application des paramètres..."

gsettings set org.gnome.mutter dynamic-workspaces $dynamicworkspace
gsettings set org.gnome.desktop.wm.preferences num-workspaces $nbdesktop
gsettings set org.gnome.desktop.screensaver lock-enabled $screenlock
gsettings set org.gnome.desktop.session idle-delay $idledelay
gsettings set org.gnome.desktop.interface color-scheme $colorscheme
gsettings set org.gnome.desktop.interface icon-theme $icontheme
gsettings set org.gnome.SessionManager logout-prompt $logoutprompt
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll $naturalscroll
gsettings set org.gnome.nautilus.preferences default-folder-viewer $folderviewer

if [[ $dist = ubuntu ]]; then
  gsettings set org.gnome.shell.extensions.dash-to-dock dock-position $position
  gsettings set org.gnome.shell.extensions.dash-to-dock extend-height $extend
fi

message "Paramètres activés"
echo
