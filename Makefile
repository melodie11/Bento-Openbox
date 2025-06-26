############################ INFORMATION ######################################

## The Bento Openbox setup is a bundle of configuration files along with 
## information meant to ease the use of the Openbox Window Manager, and
## altogether forming a solid while also light environment for the desktop. 
## To know more, please consult the lovely README provided with the sources. :)

## Authors:
## Joyce MARKOLL <contact@orditux.org> (aka Mélodie), 
## Fabrice THIROUX <fabrice.thiroux@free.fr>, and many more contributors. 

## This setup is free software: you can redistribute it and/or modify it
## under the terms of the GNU GPLv3 as published by the Free Software
## Foundation, either version 3 of the License, or any later version, unless 
## some parts belong to another projects with their own free licence. As far
## as we know all of them are provided under a licence compatible this the 
## <https://www.gnu.org/licenses>. 
## The images are our creation, and can also be reused under the terms of the 
## GNU GPLv3 licence.

## This bundle is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU GPLv3 License for more details.

## You should have received a copy of the GNU GPLv3 License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.


###############################################################################

## How to use this Makefile
#  To install, type `make install` from within the root directory of the bundle, 
#  with the administration rights.
#  To remove, type `make clean` also using administration rights.
##
#  Widely commented, it is up to you to check its content before using it,
#  to avoid any possible issue.

SHELL := /bin/bash

## Source Files and Directories
ETCSKEL = etcskel
CONFIGS = configs
XDG_MENUS = $(CONFIGS)/xdg/menus
SRC = src
BENTO = bento
THEMES = themes
ICONS = icons
PLYMOUTH = "plymouth/themes"

## Destination Directories
ETC = /etc
ETC_SKEL = /etc/skel
ETC_SYSCTL_D = /etc/sysctl.d
ETC_XDG_MENUS = /etc/xdg/menus
ETC_LIGHTDM = /etc/lightdm
ETC_POLKIT = /etc/polkit-1
USR_LOCAL_BIN = /usr/local/bin
USR_SHARE = /usr/share
USR_SHARE_THEMES = /usr/share/themes
USR_SHARE_ICONS = /usr/share/icons
PLYMOUTH_THEMES = /usr/share/plymouth/themes

## INSTALL
install:
# The file environment located in the `configs` directory goes to `/etc`
	install -m 644 $(CONFIGS)/environment $(ETC)/
	
# Folders and files from the etcskel directory go to `/etc/skel`
	rsync -rl $(ETCSKEL)/ $(ETC_SKEL)

# We will need the language files to have a symlink
# Symlink n°1 - we remove it if it exists
	ln -sf $(ETC_SKEL)/.config/openbox/lang/autostart-en $(ETC_SKEL)/.config/openbox/autostart

# Symlink n°2
	ln -sf $(ETC_SKEL)/.config/openbox/lang/menu.xml-en $(ETC_SKEL)/.config/openbox/menu.xml

# Symlink n°3
	ln -sf $(ETC_SKEL)/.config/openbox/lang/rc.xml-en $(ETC_SKEL)/.config/openbox/rc.xml

# We need the oblocale.sh script located in the `scripts` directory to be executable
	chmod a+x $(ETC_SKEL)/.config/openbox/scripts/oblocale.sh

# The files `10-magic-sysrq.conf`, `50-swappiness.conf` and `README.sysctl` located
# under the `configs` directory go into /etc/sysctl.d
	install -m 644 $(CONFIGS)/{10-magic-sysrq.conf,50-swappiness.conf,README.sysctl} $(ETC)/$(ETC_SYSCTL_D)/

# The file used to manage *the categories* for *the applications menus* go to `/etc/xdg/menus`
	rsync -rl $(CONFIGS)/$(XDG_MENUS)/* $(ETC_XDG_MENUS)/
	find $(ETC_XDG_MENUS) -type f -exec chmod 644 {} \;

# The LighDM configuration files lightdm.conf and lightdm-gtk-greeter.conf will go to /etc/lightdm.conf.d
# in case another configuration exists.
	mkdir -p $(ETC_LIGHTDM)/lightdm.conf.d
	install -m 644 $(CONFIGS)/{lightdm.conf,lightdm-gtk-greeter.conf} $(ETC_LIGHTDM)/lightdm.conf.d/

# The LightDM configuration files 01_debian.conf and 02_ubuntu.conf will go to /etc/lightdm.conf.d
	install -m 644 $(CONFIGS)/{01_debian.conf,02_ubuntu.conf} $(ETC_LIGHTDM)/lightdm.conf.d/
	
# File `55-conf.pkla` goes inside `/etc/polkit-1/localauthority/50-local.d`
	mkdir -p $(ETC_POLKIT)/localauthority/50-local.d
	install -m 644 $(CONFIGS)/55-conf.pkla $(ETC_POLKIT)/localauthority/50-local.d
	chmod 700 $(ETC_POLKIT)/localauthority

# The `xcompmgr.sh`, `xsnow.sh` and `Plymouth theme switcher` scripts will go in
# `/usr/local/bin` and will be executable
	rsync -rl $(SRC)/ $(USR_LOCAL_BIN)/
	chmod -R 755 $(USR_LOCAL_BIN)/
	
# The `bento` directory with all sub-directories and images go to `/usr/share/bento`
	rsync -rl $(BENTO) $(USR_SHARE)/
	find $(USR_SHARE)/$(BENTO)/ -type f -exec chmod 644 {} \;
	
# Openbox additional themes go into `/usr/share/themes`
	rsync -rl $(THEMES)/ $(USR_SHARE_THEMES)/
	find $(USR_SHARE_THEMES)/ -type f -exec chmod 644 {} \;

# The `Vibrantly-Simple-Dark-Pink` and `Vibrantly-Simple-Dark-Teal` icon sets and
# the two `run.svg` and `run.png` go into `/usr/share/icons`
	rsync -rl $(ICONS)/ $(USR_SHARE_ICONS)/
	find $(USR_SHARE_ICONS)/ -type f -exec chmod 644 {} \;

# Plymouth theme go into `/usr/share/plymouth/themes. /!\ needs post-install
# finishing with an update of the initramfs
	rsync -rl $(PLYMOUTH)/ $(PLYMOUTH_THEMES)/

# You will want to enable it using the provided script
	$(USR_LOCAL_BIN)/plymouth-theme-switcher.sh


## UNINSTALL
clean:
	@echo "Starting uninstallation…"

# Folders and files from the etcskel directory were in `/etc/skel`
	rm -rf $(ETC_SKEL)/{.config,.local,.bash_logout,.bashrc,.gtkrc-2.0,.jgmenurc,.profile,.vimrc,.Xdefaults,.xinitrc,.Xresources,.xsession}

# The file used to manage *the categories* for *the applications menus* was in
#`/etc/xdg/menus`
	rm -f $(ETC_XDG_MENUS)/{applications.menu,lxde-applications.menu}

# The LighDM configuration files lightdm.conf and lightdm-gtk-greeter.conf has
# gone into /etc/lightdm.conf.d in case another configuration existed.
	rm -rf $(ETC_LIGHTDM)/lightdm.conf.d/{lightdm.conf,lightdm-gtk-greeter.conf}

# File `55-conf.pkla` was inside `/etc/polkit-1/localauthority/50-local.d`
	rm -f $(ETC_POLKIT)/localauthority/50-local.d/55-conf.pkla

# The `xcompmgr.sh` and `xsnow.sh` scripts were in `/usr/local/bin`
	rm -f $(USR_LOCAL_BIN)/{xsnow.sh,xcompmgr.sh}

# The `bento` directory with all sub-directories and images go to `/usr/share/bento`
	rm -rf $(USR_SHARE)/$(BENTO)

# Openbox additional themes go into `/usr/share/themes`
	rm -rf $(USR_SHARE_THEMES)/{Imagine*}

# The `Vibrantly-Simple-Dark-Pink` and `Vibrantly-Simple-Dark-Teal` icon sets
# went into `/usr/share/icons`
	rm -rf $(USR_SHARE_ICONS)/{Vibrantly*}

# You will want to change theme before removing the Bento plymouth theme
	$(USR_LOCAL_BIN)/plymouth-theme-switcher.sh
	
# Then you need to remove it from the list of active themes
	update-alternatives --remove  default.plymouth /usr/share/plymouth/themes/bento-logo/bento-logo.plymouth

	update-alternatives --remove  default.plymouth /usr/share/plymouth/themes/bento-text/bento-text.plymouth

# Plymouth theme went into `/usr/share/plymouth/themes
	rm -rf $(PLYMOUTH_THEMES)/{bento-logo,bento-text}

# You can keep or remove the /usr/local/bin/plymouth-theme-switcher.sh script
# as you please. If you wish to remove it, uncomment the next line.
#	rm -f $(USR_LOCAL_BIN)/plymouth-theme-switcher.sh

