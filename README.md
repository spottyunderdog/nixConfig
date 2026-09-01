# Introduction
This is my personal configuration for nixos all in one nice and lovely little flake file! It come with some of the apps i use as well as the dotfiles for my hyprland and niri setups!

# Branches
Split into 4 Branches:
- nix-stable-26.05
- nix-unstable
- nix-unstable-omniflake
- development

The nix-stable-26.05 branch is based of of the stable release 26.05 of Nix OS and uses that version of the NixOS Packages Repository and home-manger release for packages and package configurations.

The nix-unstable and nix-unstable-omniflake use the unstable(Rolling) release of nixos for the Nix packages repository. The nix-unstable-omniflake uses a flake by fzakaria called omniflake found here: https://github.com/fzakaria/omniflake/tree/main.

The development is created from the nix-stable-26.05 branch and is were I work on adding new features first before adding them into the sub branches. I would caution against using this branch as this branch will see frequent commits and they are not gurenteed to be functioning.

# Installing
Follow the install steps for each branch, linked below
MAKE SURE TO READ THE IMPORTENT INFO SECTION BELLOW SO YOU KNOW WHAT EACH FILE DOES

- nix-stable-26.05: link-to-file
- nix-unstable: link-to-file
- nix-unstable-omniflake: link-to-file


# Importent Info
## Window Manger Keybinds
- hyprland.md
- niri.md
## Package List
- Packagelist.md link
## Options
- Optionlist.md link
## File Structure
- Based of the nix-stable-26.05 branch
[![GitHubTree](https://img.shields.io/badge/GitHubTree-nixConfig-blue?style=flat-square)](https://githubtree.mgks.dev/repo/spottyunderdog/nixConfig/nix-stable-26.05/?ref=badge)

## Module Breakdown by folder
### features
This part of the flake contains all of the modules that determine the apps sets you can use, the dotfiles and declare app configs, and virulization.

First up in here is the folder called *apps*. This folder contains all the modules the flake uses to determine what apps the user may or not want on their host. Apps are split into the following modules:
- Coms Apps
- Dev Apps
- Editing Apps
- Extra Apps
	- Cosmetic Apps
	- Extra Apps
	- Extra Browsers
	- Extra Shells
	- Proton Apps
- Flatpak Support
- Gaming Apps
- Media Apps
- Needed Apps
- Packages
- Remote Access Apps
- Utility Apps

The packages.nix module and Extra Apps module act as nodes collecting the other app modules all together in on module so we don't have to import a long slog of files in our host. The full list of packages can be found here[place a link to the final list here]

Next Up is our *homemanager* folder. This is were any per app configurations, like shell aliases, and dotfiles, like my niri and noctalia dots, live. You'll find the modules that define the per app configs inside the *appConfigs* folder, and any dotfile stuff inside the *dotFiles* folder

Lastly we have the *virtualization* folder and the homemanager.nix file. This folder quiete plainly contains the modules that allow us to pick and choose different virtualizaion software to use, ie VMWare or Virtual Machine manager, this is also where container software will live once i get around to figuring out how to properly add podman and docker to the flake. The homemanager.nix file enables and sets up our homemanager settings, I'd advise against messing with this file unless you know what your doing.

### hosts
This folder is were your host configurations will live.

As of the time of writing there are 2 existing host configurations. The one I myself am using in the folder "schoolLaptop" and templateHost.

The template host contains most of the files you'll need to configure your own system (the exception is for any users that you want accross all your systems those are located in sharedSystemConfigs). 

Its files look something like this:
├── users
│ └── nixUser.nix
└── configuration.nix

The users folder contains all host specific users configuration files, the example user here is nixUser.nix, as well as the options to toggle certain app specific configs, like bash settings, and dotfiles, like the niri configs.

the configuration.nix file contains all modules needed to set up your system. It also contains all toggles for system settings and packages.

#### configuration.nix
Contains Modules:
	flake.nixosConfigurations.\<hostName\>
	flake.nixosModules.\<hostName\>Users
	flake.nixosModules.\<hostName\>Hardware
	flake.nixosModules.\<hostName\>Configuration

the \<hostName\> is controled by the hostName variable.

nixosConfigurations.\<hostName\>\: 
	Declares the system and sets the \<hostName\>Configuration module for configs.

nixosModules.\<hostName\>Users: 
	Imports your host specific users.

nixosModules.\<hostName\>Hardware:
	Where the hosts hardware config lives. Can optionally import the hardware-configuration.nix file located in the /etc/nixos directory, however this is not recommended as it requires the --impure option added to your flake. To add your hardware config just paste the contents of the hardware-configuration.nix file into the module.

nixosModules.\<hostName\>Configuration:
	Imports the packages, homeManager, systemSettings, crossSystemUsers, \<hostName\>Hardware, & \<hostName\>Users modules. 
	Contains all settings that can be configured for a specific host, like hostname what DE/WMs you want, and more.
	Defaults:
		Host Name: Matches Hostname Variable.
		Desktop Envirnment: KDE Plasma
		Kernel: Nix OS Default Kernel.
		Enabled Package sets: Flatpak, neededApps, utilityApps, & extraShells
		All other togglable modules are disabled by default, though are listed for use.

#### nixUser.nix
This is the template for a host specific user. Has two variables:
\<hostName\> and \<userName\>. The \<hostName\> variable *MUST* match the \<hostName\> variable in configuration.nix otherwise it won't import properly.

Modules:
	flake.nixosModules.\<hostName\>\-\<userName\>
	flake.homeConfigurations.\<userName\>
	flake.homeModules.\<hostName\>\-\<userName\>

nixosModules.\<hostName\>\-\<userName\>\:
	Your user configuration. Automaticly adds the user to its needed groups, defines what shel, and imports the homeModules.\<hostName\>\-\<userName\>

homeConfigurations.\<userName\>\:
	some homemanager setings, sets the homemanager dir to the users directory.

homeModules.\<hostName\>\-\<userName\>\:
	Imports the appconfigurations, and allows thge user to toggle which app configurations, and WM dotfiles you would like to use.

### sharedSystemConfigs
Folders:
	Kernels
	graphcisDrivers
	sessionManagement
	users
Files:
	bootloader.nix
	garbageCollection.nix
	hibernation.nix
	locale.nix
	pipewire.nix
	swap.nix
	systemSettings.nix

#### Kernels
This folder contains the modules that can control the kernel that you want to use. This flake gives you the option to use the regular linux kernels, (latest or lts), and some of the CachyOS kernels. 

Provided Kernels:
	Default NixOS Linux Kernel
	Linux Latest
	Linux 6.18 (LTS Version)
	Linux 6.12 (LTS Version)
	CachyOS Latest (And Architechture varients)
	CachyOS LTS (And Architechture varients)
	CachyOS Hardened
	CachyOS Server

#### graphicsDrivers
Contains the modules for nvidia, amd, and intel graphics drivers. Allows the user to toggle the drivers they need.

#### sessionManagement
Contains the modules for wayland and x11 sessions. And the display manager configuration file.
Wayland DEs & WMs:
	GNOME
	KDE Plasma
	Hyprland
	Niri
x11 DEs:
	XFCE
Display Manager:
	SDDM (Default, If Gnome is used, then it uses GDM)
SDDM uses the SilentSDDM theme, with the "rei" config enabled by default. To disable the theme or change wich config silentSDDM is using see the dispayManager.nix file.

#### users
Where your system wide hosts are stored. Currently has 2 files, being spotty.nix and users.nix. users.nix is used to import all of the multi system users and spotty.nix is a user file configured in a simaler mmanner to the host-specific users.

#### bootloader.nix
Configures the bootloader, grub, is not toggleable.

#### garbageCollection.nix
Configures automatic garbageCollection, toggleable

#### hibernation.nix
Configures hibernation, requires swap to be enabled, toggleable

#### locale.nix
Configures your locale settings. Not toggleable

#### pipewire.nix
Configures your pipewire settings. Not toggleable

#### swap.nix
Configures swap settings. Specificly enables Zswap. toggleable.

#### systemSettings.nix
Imports all modules, with the exception of the crossSystemUsers module (users.nix), which is imported by the hosts that want to use them.
This file:
	enables the bash shell
	enables systemd in initrd
	enables the use of unfree software
	enables networkmanager & wireless networking
	enables the use of flakes
	enables printing support
	enables SSH and SUID wrappers
	setts the stateversion to 26.05
	sets the default values of swap, hibernation, and autoGarbageCollection to false.
	installs the jetbrains mono, firacode nerd font, and jetbrains mono nerd fonts.