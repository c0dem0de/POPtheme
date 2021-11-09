#! /bin/bash

# Updates repo and system resources
# sudo apt update && sudo apt upgrade -y ; sudo apt autoremove

# Install Gnome tweaks, shell
echo "⟹ INSTALLING GNOME TWEAKS & SHELL"
echo ""
sudo apt install gnome-tweak-tool gnome-shell -y
echo " Gnome Tweaks ✔"


# Install Gnome Extensions-installer
echo "⟹ INSTALLING GNOME EXTENSION-INSTALLER"
echo ""
cd ~/
sudo apt install wget
wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/bin/




# Install Gnome extensions
echo "⟹ INSTALLING GNOME EXTENSIONS"
echo ""
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
	["Time ++"]="gnome-shell-extension-installer 1238"
	["Unite"]="gnome-shell-extension-installer 1287"
	["Babar Task"]="gnome-shell-extension-installer 4000"
	["Coverflow alt+tab"]="gnome-shell-extension-installer 97"
	["Floating Dock"]="gnome-shell-extension-installer 3730"
)

parse_list() {
    for name in "${!EXTENS[@]}"
    do
      
      ${EXTENS[$name]}
      echo "⎈ $name ✔"

    done
}
parse_list
dconf load /org/gnome/shell/extensions/ < ~/Downloads/POPtheme/extension-settings.dconf
gsettings set org.gnome.shell disable-user-extensions false




# Install Gnome themes
echo "⟹ INSTALLING GNOME THEMES"
echo ""
cd ~/
dir="$(find -name .themes)" 
if [ "$dir" = "./.themes" ];then
	cd ~/Downloads/POPtheme/Themes/
	mv ./* ~/.themes/
	echo "⎈ Themes ✔"
else
	mkdir .themes
	cd ~/Downloads/POPtheme/Themes/
	mv ./* ~/.themes/
	echo "⎈ Themes ✔"
fi

dir2="$(find -name .icons)" 
if [ "$dir" = "./.icons" ];then
	cd ~/Downloads/POPtheme/Icons/
	mv ./* ~/.icons/
	echo "⎈ Icons/cursors ✔"
else
	mkdir .themes
	cd ~/Downloads/POPtheme/Icons/
	mv ./* ~/.icons/
	echo "⎈ Icons/cursors ✔"
fi


# Set Gnome themes
echo "⟹ SETTING GNOME THEMES"
echo ""
gsettings set org.gnome.desktop.interface applications-theme 'Peace-Harmony-GTK'
echo "⎈ applications theme ✔"
gsettings set org.gnome.desktop.interface cursor-theme 'Fluent-dark-cursors'
echo "⎈ cursor theme ✔"
gsettings set org.gnome.desktop.interface icons-theme 'Tela-circle-purple'
echo "⎈ icons theme ✔"
gsettings set org.gnome.desktop.interface shell-theme 'Flat-Remix-Blue-Dark-fullPanel-shell'
echo "⎈ shell theme ✔"



# Install/Set wallpaper
echo "⟹ SETTING WALLPAPER"
echo ""
cd ~/Pictures
mkdir Wallpapers
mv ~/Downloads/POPtheme/popwall.png ~/Pictures/Wallpapers/ 
usrnm="$(whoami)"
gsettings set org.gnome.desktop.background picture-uri "file:/home/$usrnm/Pictures/Wallpapers/popwall.png"
echo "Wallpaper ✔"
