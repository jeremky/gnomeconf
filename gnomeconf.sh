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
gsettings set org.gnome.mutter dynamic-workspaces $dynamicworkspace
gsettings set org.gnome.desktop.wm.preferences num-workspaces $nbdesktop
gsettings set org.gnome.desktop.screensaver lock-enabled $screenlock
gsettings set org.gnome.desktop.session idle-delay $idledelay
gsettings set org.gnome.SessionManager logout-prompt $logoutprompt
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll $naturalscroll
gsettings set org.gnome.nautilus.preferences default-folder-viewer $folderviewer
gsettings set org.gnome.desktop.interface color-scheme $colorscheme

if [[ $dist != bazzite ]]; then
  gsettings set org.gnome.shell.extensions.dash-to-dock dock-position $dockposition
  gsettings set org.gnome.shell.extensions.dash-to-dock extend-height $dockextend
  gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme $dockcustomtheme
  gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink $dockshrink
  gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action $dockscroll
  gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup $dockdisableview
  gsettings set org.gnome.shell.extensions.dash-to-dock click-action $dockclick
fi

if [[ $dist != ubuntu ]]; then
  gsettings set org.gnome.desktop.interface accent-color $color
  gsettings set org.gnome.desktop.interface icon-theme $icontheme
  gsettings set org.gnome.shell.extensions.user-theme name $shelltheme
fi

if [[ $dist = fedora ]]; then
  gsettings set org.gnome.shell.extensions.forge window-gap-size $forgegap
  gsettings set org.gnome.shell.extensions.forge window-gap-size-increment $forgegap
  gsettings set org.gnome.shell.extensions.forge stacked-tiling-mode-enabled $forgestack
  gsettings set org.gnome.shell.extensions.forge tabbed-tiling-mode-enabled $forgetab
  gsettings set org.gnome.shell.extensions.forge focus-border-toggle $forgeborder
  gsettings set org.gnome.shell.extensions.forge dnd-center-layout $forgednd
fi

message "Configuration de Gnome effectuée"
