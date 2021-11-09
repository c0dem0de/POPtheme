#! /bin/bash

# Updates repo and system resources
sudo apt update && sudo apt upgrade -y ; sudo apt autoremove

# Install Gnome tweaks, shell
echo "⟹ INSTALLING GNOME TWEAKS & SHELL"
sudo apt install gnome-tweak-tool gnome-shell gnome-shell-extensions -y


# Install Gnome Extensions-installer
echo "⟹ INSTALLING GNOME EXTENSION-INSTALLER"
cd ~/
sudo apt install wget
wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/bin/

# Install Gnome extensions
echo "⟹ INSTALLING GNOME EXTENSIONS"
declare -A EXTENS
EXTENS=(
	["User Themes"]="gnome-shell-extension-installer 19"
	["GSconnect"]="gnome-shell-extension-installer 1319"
	["Sound input and output Chooser"]="gnome-shell-extension-installer 906"
	["Clipboard Indicator"]="gnome-shell-extension-installer 779"
	["Lock Keys"]="gnome-shell-extension-installer 36"
	["Removeable drive menu"]="gnome-shell-extension-installer 7"
	["Workspaces Thumbnails"]="gnome-shell-extension-installer 2557"
	["Screenshot Tool"]="gnome-shell-extension-installer 1112"
	# ["Time ++"]="gnome-shell-extension-installer 1238"
	# ["Unite"]="gnome-shell-extension-installer 1287"
	# ["Babar Task"]="gnome-shell-extension-installer 4000"
	# ["Coverflow alt+tab"]="gnome-shell-extension-installer 97"
	# ["Floating Dock"]="gnome-shell-extension-installer 3730"
)

parse_list() {
    for name in "${!EXTENS[@]}"
    do
      
      ${EXTENS[$name]}
      echo "⎈ $name ✔"

    done
}

mv ~/Downloads/POPtheme/Extensions/ ~/.local/share/gnome-shell/extensions/


# Install Gnome themes
echo "⟹ INSTALLING GNOME THEMES"
cd ~/
dir="$(find -name .themes)" 
if [ "$dir" = "./.themes" ];then
	mv ~/Downloads/POPtheme/Themes/ ~/.themes/
else
	mkdir .themes
	mv ~/Downloads/POPtheme/Themes/ ~/.themes/
fi

