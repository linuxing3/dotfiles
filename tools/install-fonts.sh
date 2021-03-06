#!/bin/bash

# install unzip just in case the user doesn't already have it.
sudo apt-get install unzip -y

fonts="FiraCode Hack JetBrainsMono RobotoMono SourceCodePro IBMPlexMono"
version="2.1.0"

setup_console_font() {
	echo "
	# CONFIGURATION FILE FOR SETUPCON

	# Consult the console-setup(5) manual page.

	ACTIVE_CONSOLES="/dev/tty[1-6]"

	CHARMAP="UTF-8"

	CODESET="Lat38"
	FONTFACE="TerminusBold"
	FONTSIZE="11x22"

	VIDEOMODE=

	# The following is an example how to use a braille font
	# FONT='lat9w-08.psf.gz brl-8x8.psf'
	" 

	sudo dpkg-reconfigure console-setup
}

fontface=$(dialog --title " Nerd Fonts 一键安装自动脚本" \
	--checklist "请输入:" 20 70 5 \
	"FiraCode" "Fira Code Nerd fonts" 0 \
	"Hack" "Hack Nerd Fonts" 0 \
	"JetBrainsMono" "JetBrains Mono" 0 \
	"RobotoMono" "Roboto Mono" 0 \
	"SourceCodePro" "Source Code Pro" 0 \
	"IBMPlexMono" "IBM Plex Mono" 0 \
	"ConsoleFont" "Setup Console Font" 0 \
	3>&1 1>&2 2>&3 3>&1)

location="/usr/share/fonts/truetype/${fontface}"
url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${fontface}.zip"

echo "Installling ${fontface}"
cd
if [[ ! -d fonts ]]; then
	mkdir fonts
fi
cd fonts

rm -rf ${fontface}
mkdir ${fontface}
cd ${fontface}

echo "Fetching ${fontface} fonts from nerd-fonts releases page"
wget $url
unzip ${fontface}.zip
rm ${fontface}.zip

sudo rm -rf $location
sudo mkdir -p $location

if [[ -d $location ]]; then
	sudo cp *.ttf "${location}/"
	sudo cp */*.ttf "${location}/"
	sudo fc-cache -fv
	dialog --title "Success" --msgbox "Installed ${fontface} ${version}" 5 70
else
	dialog --title "Failed" --msgbox "Not Installed ${fontface} ${version}" 5 70
fi

echo "For all fonts, clone the repository and install"
echo "git clone https://github.com/ryanoasis/nerd-fonts"

echo "Setup console font to protect your eyes..."
setup_console_font
echo "Enjoy!"

