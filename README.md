# Bento-Openbox
The Openbox light and advanced Window Manager with a setup creating a user
friendly desktop environment in Linux distributions.

## Presentation
(Openbox)[https://openbox.org] is a Window Manager developped by Dana Jansens
and several other people, meant for simplicity and lightness in the use of
GNU/Linux distributions.

Bento Openbox is a recipe to provide the Openbox Window Manager along with two
other tools and a set of prebuilt configurations to make it easy for anyone to
use.

This allows your GNU/Linux operating system to be lighter than most, and is fit
to be used in a variety of aging computers.


## Brief history
It has been delivered in several prebuilt distributions since 2009, through
(Linuxvillage)[https://linuxvillage.org], and before at (PCLinuxOS-Fr.org)[https://pclinuxos-fr.org]

When remixed using PCLinuxOS as a basis, its code name was Bonsaï, and meant to
be used in computers with low ressource.

While rebuilt using Ubuntu as a basis, a first set of content had been uploaded
to Gitlab: https://gitlab.com/bento-openbox.

Among else, you can find a mind map showing the organisation within the ISO
images filesystem tree directory:
https://gitlab.com/bento-openbox/bento-filesystem/-/tree/master

With this new repository, users get a full setup and information to enable them
to use it in the context of different free/opensource distributions.

## How to use it?
You can use it in a distribution of your choosing, or rebuild one of your choice
using all or part of the provided configuration and information.

Please let us know if it is useful to you and in what way?

## Can you modify things?
You can modify many things, such as the default sets of icons, the GTK theme,
the window theme, background and so on. If you make changes to the openbox
configuration setup (menu.xml, rc.xml files) proceed with caution.

If you break something while doing so, you can always copy the original files
back from /etc/skel to your personal directory.

## Dependencies
To get the full benefits from the files provided here, you will need the
following packages:
* openbox
Already introduced in the above presentation.

* obconf
If your distribution does not pull it in when you install openbox, you should
add this one, which will let you configure several items in a graphical window,
such as the windows themes, the margins, the openbox menu fonts…

* openbox-menu
It provides a dynamic menu such as what can be found in regular Desktop
Environments. To do that, it makes use of the library libmenu-cache from the
LXDE project. It allows avoiding **other dependencies** from the LXDE Desktop
Manager. The configuration files provided place a dynamic Applications menu in
the Openbox menu (right-clic to the desktop).

If your distribution does not provide it, you can package it, or compile it from
its author's repository : https://github.com/fabriceT/openbox-menu. If you
package it for your distribution, we will be happy to read about it!

* obsession
It provides a shutdown/reboot/logout/sleep/hibernation menu such as the one
provided by LXDE. It also comes from a component of the LXDE project, but unlike
the one belonging to the LXDE suite, it comes with **a limited set** of
dependencies.

If you distribution does not provide it, you can package it, or compile it from
its author's repository : https://github.com/fabriceT/obsession. If you package
it for your distribution, we will be pleased to read about it!

## Recommended packages
### A session manager
We like lightdm, but you can use something else, such as nodm, or slim if you
like them better. We provide configuration files for lightdm.

### A file manager
You can use PCManFM as file manager. It will not only allow you to manage your
files, but also allow you to manage a background for your desktop, and display
icons.

More options can be chosen, though. (Desktop without icons, root background with
or without a wallpaper : have a look into the `autostart` file in the `openbox`
directory and at the (Openbox)[https://openbox.org] website).

### A panel
We used to have `LXPanel` in Bento Openbox setups, but sometimes we'd rather
have `tint2`, if we want it even lighter or if `LXPanel` meets with issues.

If we choose `tint2`, we can use `jgmenu` for a dynamic menu associated to
LXPanel. The `volumeicon` package (aka `volumeicon-alsa`) is desirable to have
when using tint2. It sits in the system tray.

## A configuration tool
LXAppearance makes it easy to select and configure fonts, a GTK theme, an icon
theme, and more.

## Additional tool
Maybe your distribution does not already use Lightdm as Desktop Manager. If not,
you need to consider either using it, or if you want to use even a lighter one,
you can remove the lightdm.conf file before using the setup.

## Optional packages
Bento Openbox Remixes comes with a choice of several packages. Here is a small
list:
- Sakura, a light terminal with custom setup tools
- htop, a semi-graphical `top like` processes monitoring and managing.
- mc, the midnight-commander semi-graphical swiss knife type file-manager
- volumeicon, to provide a volume manager on the panel in case you use tint2 as
the default panel
- feh, in case you want to have a root desktop with a background of your choice
(and no icons on the desktop)
- xcompmgr, for transparency, is lighter and smaller than compton and in 2025
still works!

## Very Optional old school packages
In order to use the xshow.sh  script, the old xsnow would need to be compiled
from source and make use of a a root desktop, and eventually the *idesk* icons.

If interested, the `menu.xml` files already contains the necessary setup ready
to be activated to start the xsnow.sh script, while the `autostart` files
contains alternative configurations to use feh in order to display a wallpaper
as a “root” background.

## Aging components
Yes, in 2025, openbox, openbox-menu, and obsession are old! But they still work
fine. I have been using them on a daily basis in my computers since many years
and I still do!

## Benefits of this project
Using prebuilt configuration files initially provided by experimented users, and
improved thanks to the feedback of a whole community of users, back in the years
2009 to 2011, will allow you to use it *out of the box* once installed in your
distribution.

## Prebuilt distributions
Some Bento Openbox Remix (built on Ubuntu) editions have been made available at
[Linuxvillage](https://linuxvillage.org) here and then since 2012 and some
built from antiX Linux since the last years. You can follow [Linuxvillage](https://linuxvillage.org)
to keep posted if you'd like to.

If you use it in a new distribution or in a remix of your's, we'd love to hear
about it!

## About the Openbox configuration files
You find them in the **.config/openbox** directory. The first time you use them,
you will find a `Switch language` menu in the Openbox right-click main menu. It
lets you choose between English, French, and German.

You will find an additional README there with related information, useful when
you want to customize further.

## Additional configuration files
### Storage and power managements
Polkit authorizations are configured to allow access to different services in
the user environment (no root permissions needed), such as storage related
permissions, power management permissions, and access to internal drives using a
live session.

### Themes, icons
Additional themes for Openbox and for icons are included and installed by
default using the Makefile. You can change it as you like best.

### Plymouth theme
A dedicated plymouth theme will be installed in the system, but it will need to
be selected.

We built a script, called from the Makefile, to make it easier. You can use it
to install the new Plymouth theme, then to change for another Plymouth theme at
any time.

You need to switch theme first if you  decide to uninstall the whole Bento
Openbox setup. You can use the Makefile to do that, using the `make clean`
command from within the bundle directory.

If you prefer to use command lines:
There are 2 directories: *bento-logo* and *bento-text* and there must have 2
symlinks created with relevant command lines. How to do that:
In the console su or sudo to root, then after all files have been copied into
`/usr/share/plymouth/themes`:

```bash
# rsync -r bento-logo bento-text /usr/share/plymouth/themes/                   
# update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/bento-logo/bento-logo.plymouth 100
#
```

The `update-alternatives` command line is a sequence of instructions composed
with : *link name, name, path, priority*. The priority number can be adapted.

The next command line allows checking the result while displaying the list
of themes and their priorities.
`# update-alternatives --config default.plymouth`

The initramfs needs to be updated:
`# update-initramfs -u`

### Other files
You will find them abundantly commented in the Makefile.

## Final details

The keyboard-configuration.desktop (from etcskel/.local/share/applications)
starts a terminal with a `dpkg-reconfigure` command line, can be removed if not
needed.

In some distributions, the Synaptic package manager is started with `synaptic-pkexec`
If so, the `exec synaptic` line in the menu.xml files need to be adapted.
(`synaptic-pkexec` instead of `sudo -S synaptic`, for example).

## Last advice
You won't need a full fledged Desktop Manager in your distribution prior to
using this setup, but if you have one, proceed with caution to ensure not to
mess with your usual setup by installing this batch. You might want to test on
a fresh install first, on a spare computer or in a virtual machine.
