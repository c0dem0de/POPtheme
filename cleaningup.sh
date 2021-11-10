#! /bin/bash

cd ~/


# 		-- update sys & repo
# sudo apt update && sudo apt upgrade -y 
# sudo apt autoremove
# clear


# 		-- install some packages
printf "\n⟹  INSTALLING PACKAGES\n"

sudo apt install gnome-shell -y && echo "⎈ Gnome Shell ✔"
sudo apt install gnome-tweak-tool -y && echo "⎈ Gnome Tool ✔" 
sudo apt install wget -y && echo "⎈ wget ✔"
sudo apt install curl -y && echo "⎈ curl ✔"
sudo apt install git -y && echo "⎈ git ✔"
wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer" -y && echo "⎈ gnome extension installer ✔"
chmod +x gnome-shell-extension-installer && echo "		- made executable ✔"
sudo mv gnome-shell-extension-installer /usr/bin/ && echo "		- moved to /bin ✔"


# 		-- install themes
printf "\n⟹  INSTALLING GNOME-THEMES\n"

dir="$(find -name .themes)" 
if [ "$dir" = "./.themes" ];then
	cd ~/Downloads/POPtheme/Themes/
	mv ./* ~/.themes/ && echo "		- themes ✔"
else
	mkdir .themes
	cd ~/Downloads/POPtheme/Themes/
	mv ./* ~/.themes/ && echo "		- themes ✔"
fi

cd ~/
dir2="$(find -name .icons)" 
if [ "$dir" = "./.icons" ];then
	cd ~/Downloads/POPtheme/Icons/
	mv ./* ~/.icons/ && echo "		- icons ✔"
else
	mkdir .icons
	cd ~/Downloads/POPtheme/Icons/
	mv ./* ~/.icons/ && echo "		- icons ✔"
fi


# 		-- install extensions
printf "\n⟹  INSTALLING GNOME-EXTENSIONS\n"

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
	["Bluetooth Quick Connect"]="gnome-shell-extension-installer 1401"
	["Time ++"]="gnome-shell-extension-installer 1238"
	["Unite"]="gnome-shell-extension-installer 1287"
	["Babar Task"]="gnome-shell-extension-installer 4000"
	["Coverflow alt+tab"]="gnome-shell-extension-installer 97"
	["Floating Dock"]="gnome-shell-extension-installer 3730"
)

install_list() {
    for name in "${!EXTENS[@]}"
    do
      
      ${EXTENS[$name]} && echo "⎈ $name ✔"

    done
}
install_list
dconf load /org/gnome/shell/extensions/ < ~/Downloads/POPtheme/extension-settings.dconf


# 		-- install rofi menu
printf "\n⟹  INSTALLING CUSTOM-ROFI\n"

cd ~/
git clone https://github.com/c0dem0de/ROFI.git
cd ~/ROFI/
chmod +x INSTALL.sh
./INSTALL.sh && echo "⎈ ROFI ✔"


# 	---	restart gnome shell	---
killall -3 gnome-shell
sleep 5


# 		-- Set wallpaper, enable extensions, set themes
printf "\n⟹  SETTING UP THINGS\n"

mv ~/Downloads/POPtheme/Wallpapers ~/Pictures/ 
usrnm="$(whoami)"
gsettings set org.gnome.desktop.background picture-uri "file:/home/$usrnm/Pictures/Wallpapers/unsplash4.jpg" && echo "⎈ wallpapers ✔"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'sh -c '~/ROFI/MAIN-MENU.sh''
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>S'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'ROFI-MENU'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'nautilus --new-window'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Super>E'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Files'


declare -A EXTENON
EXTENON=(
	["User Themes"]="user-theme@gnome-shell-extensions.gcampax.github.com"
	["Unite"]="unite@hardpixel.eu"
	["Screenshot Tool"]="gnome-shell-screenshot@ttll.de"
	["Removeable drive menu"]="drive-menu@gnome-shell-extensions.gcampax.github.com"
	["GSconnect"]="gsconnect@andyholmes.github.io"
	["Clipboard Indicator"]="clipboard-indicator@tudmotu.com"
	["Lock Keys"]="lockkeys@vaina.lt"
	["Babar Task"]="babar@fthx"
	["Time ++"]="timepp@zagortenay333"
	["Workspaces Thumbnails"]="workspaces-thumbnails@fthx"
	["Bluetooth Quick Connect"]="bluetooth-quick-connect@bjarosze.gmail.com"
	["Floating Dock"]="floating-dock@nandoferreira_prof@hotmail.com"
	["Sound input and output Chooser"]="sound-output-device-chooser@kgshank.net"
	["Coverflow alt+tab"]="CoverflowAltTab@palatis.blogspot.com"
)
enable_extens() {
    for name in "${!EXTENON[@]}"
    do
      
	  gnome-extensions enable ${EXTENON[$name]} && echo "⎈ $name Enabled ✔"

    done
}
enable_extens


gsettings set org.gnome.desktop.interface gtk-theme 'Peace-Harmony-GTK' && echo "⎈ applications theme ✔"
gsettings set org.gnome.desktop.interface cursor-theme 'Fluent-dark-cursors' && echo "⎈ cursor theme ✔"
gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-purple' && echo "⎈ icons theme ✔"
gsettings set org.gnome.desktop.interface shell-theme 'Flat-Remix-Blue-Dark-fullPanel-shell' && echo "⎈ shell theme ✔"
