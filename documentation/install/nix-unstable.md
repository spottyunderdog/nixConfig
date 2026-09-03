# Instalation:
## Geting the Repo
1. Clone the nix-unstable Branch and enter repo
```
git clone --single-branch --branch nix-unstable https://github.com/spottyunderdog/nixConfig
cd nixConfig
```
2. Delete the .git directory if you plan on adding or deleting any files, as the flake will not recognize and new files unless they are staged or commited. If you don't plane on removing the git repo make sure you stage and/or commit any changes you make or the rebuild command won't recognize the changes you've made to the configuration.
```
rm .git/ -rf
```

## Configuring the your Host(s) 
Before we do anything we need to configure our host or hosts. To begin lets start with host name and usercreation.
### Host Name And User Creation
1. Navigate to the nixConfig/modules/hosts directory.
```
cd nixConfig/modules/hosts
```
2. Inside you'll find 2 folders, Look for the one called `templateHost` and make a copy of it, with the name of your new host.
3. Then enter the newly created host folder and open the `configuration.nix` file with your prefered text editor, like vim, nano, or neovim. Next, change the value of the `hostName` variable to the name of your host and save and quit the file.
```
cd <hostName>/
nano configuration.nix
```
4. A. Next, if you want to configure a user for only this host, enter the users directory (the one inside your hosts directory), and rename the `UserTemplate.nix` file to `<hostName>-<username>.nix`, where `<hostName>` is the name of your host and `<username>` is the name of the user. If you plan on making multiple user accounts, make new files following the `<hostName>-<username>.nix` format and copy the contents of `UserTemplate.nix` into each user file.
	B. Open Your user file (`<hostName>-<username>.nix`) with your prefered text editor, and change the variable `hostName` to the name of your host (*make sure it matches the value you set for `hostName` in `configuration.nix` otherwise it won't compile!*). Then set the `userName` varible to the username that you want. 
	C. Finally, we need to make sure the user(s) are properly imported in `configuration.nix`. Open the `configuration.nix` file, and look for a module with the name `flake.nixosModules."${hostName}Users"`. In the imports section rename the exitsing `self.nixosModules."${hostname}-nix` module to `self.nixosModules."${hostName}-<username>"` (Keep in mind that `<username>` is the name of the user you just made). If you made multiple user accounts, add them into the imports module with the same naming convention.
5. If you want to make a user(s) that is used accross multiple different hosts, navigate to `nixConfig/modules/sharedSystemConfigs/users` Then make a file called `users-<username>.nix`, where `<username>` is the username for the user, and copy the contents of `users-template.nix` into your user file. Then, change the value of the `userName` variable to the username of the user, and save and quit. then open the `users.nix` file and replace the `self.nixosModules."users-template"` module with `self.nixosModules."users-<username>"`. If you made multiple users add them in following that same naming convention.
### Host Hardware Configuration
Next we need to specify the hardware configuration of our host(s), this section will have to be repeated for each host you plan on making.

You have 2 options for specifying the hardware configuration of the host.
1. Importing the `hardware-configuration.nix` file from `/etc/nixos` (simplest)
2. Copying the Contents of an existing hardware configuartion file (usually the `/etc/nixos/hardware-configuration.nix file`) to the hardware module in your hosts `configuration.nix` (recommended)
The first option does allow for easier transfers accross devices, or device resestsm, however, do to the nature of this flake, you will have to add the `--impure` flag to your rebuild command.

#### A. Importing hardware-configuration.nix as module
1. Make sure the `hardware-configuration.nix` file exists by running the command `cat /etc/nixos/hardware-configuration.nix` if you get an output then it exists. If not present you will have to [regenerate the configuration file](https://wiki.nixos.org/wiki/Nixos-generate-config).
2. Once you have verified that the file exists, open the `configuration.nix` file in for your host and scroll down the the module called `flake.nixosModules."${hostName}Hardware"` and uncomment the line that says `imports = [ /etc/nixos/hardware-configuration.nix ];`
#### B. Copying a the contents of an existing hardware configuration
For this guide we will be assuming that your hardware config is located in `/etc/nixos/hardware-configuration.nix`. 
1. Open `hardware-configuration.nix` and you should see something like this:
```
{config, lib, pkgs, modulesPath, ... }: {

imports = [ (modulesPath + "/installer/scan/not-detected.nix")];
boot.initrd.availableKernelModules = [ ... ];
boot.initrd.kernelModules = [ ];
boot.kernelModules = [ ... ];
boot.extraModulePackages = [ ];
fileSystems."/" = { ... };
fileSystems."/home" = { ... };
fileSystems."/nix" = { ... };
fileSystems."/boot" = { ... };
swapDevices = [ ];
nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
```
2. Copy the everything between the `{config, lib, pkgs, modulesPath, ...}: {` and the `}` at the end, then close out of the file.
3. In the `nixConfig/modules/host/<hostName>/configuration.nix`, scroll down to the module called `flake.nixosModules."${hostName}Hardware"`
4. Then paste what you just copied inside the module (underneath the comments telling you were the hardware configuration goes, feel free to delete these.) You should end up with something like this:
```
flake.nixosModules."${hostName}Hardware" = { config, lib, pkgs, modulesPath, ... }: {
imports = [ (modulesPath + "/installer/scan/not-detected.nix")];
boot.initrd.availableKernelModules = [ ... ];
boot.initrd.kernelModules = [ ];
boot.kernelModules = [ ... ];
boot.extraModulePackages = [ ];
fileSystems."/" = { ... };
fileSystems."/home" = { ... };
fileSystems."/nix" = { ... };
fileSystems."/boot" = { ... };
swapDevices = [ ];
nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
};
```

### Host Setting Configurations And User Configurations.
Lastly we will need to specify any host specific settings we want, and activate any app configurations we want our users to have. Any app configs, or WM dotfiles will need to be configured for each user individualy.
#### System configuration
1. Inside the flake, enter your host directory, and open the `configuration.nix` file with your prefered text editor.
2. Scroll down until you get to the module called `flake.nixosModules."${hostName}Configuration"`. This is were your hosts config lives. If you don't want the host to use the cross system users, or host specific users comment out, or remove the modules that refer to "users" in the imports section of the host configuration module.
3. The template your building off of will have all of the option for system configurations there for you, though if you would like to see the full list of options available, see [here](link)
4. Simply enable the options for what you want to use and disable the things you don't want or need for your host.
5. If your host has an Nvidia gpu with a iGPU, you want to enable NVIDIA PRIME, which is located at the bottom of the file, follow the details [here](https://nixos.wiki/wiki/Nvidia) for setting it up properly for your system.
6. For kernels you can only have one enabled at a time, so make sure you don't enable any other kernel.
7. All options are disabled by default, and must be enabled by the you in order to be used.
#### User Configuration & App Config 
***Important***
The included appconfigurations, need to be enabled on a per-user basis, so if you want certain configs, like WM Dotfiles, to be enabled for every user you will need to enable them for all of your users

1. Open the user file for your the user you would like to configure ( either `users-<username>.nix` or `<hostname>-<username>.nix`) in your prefered text editor.
2. The first module, either `flake.nixosModules."users-${username}"` or `flake.nixosModules."${hostName}-${userName}`, you'll find your user configuration. Here you can configure the groups a user is a part of, what their default shell is, and any user specific packages they might have.
3. At the bottom of the file you will find a module called `flake.homeModule."${userName}Module"` or `flake.homeModule."${hostName}-${userName}Module"` this module is were you'll enable the app specific configurations you want. Here you'll be able to enable/disable: Shell Configurations, Hyprland and Niri Configurations, Noctalia Configurations, Kitty Configurations, etc. 
4. If your are planning only using my Niri or Hyprland configs, you will have some addition configuration that needs to be done. For that information see the Post Install Setup section below.

## Building the system
Now that you've configured your Host its now time to install the configuration onto your system.

1. Enable support for flakes if you haven't already,:
```
# Add the line to your configuration.nix file in /etc/nixos
nix.settings.experimental-features = [ "nix-command" "flakes" ];
# Then run 
sudo nixos-rebuild switch
```
2. Navigate into the flake's directory
```
# Assumes you clone the repo into your home directory
cd ~/nixConfig
``` 
3. Rebuild your system from the flake with the below command, replaceing `<hostname>` with the name of the host you are building:
```
sudo nixos-rebuild switch --flake .#<hostName>
```
If you used an absoulute path to your `hardware-configuration.nix` file ie: `/etc/nixos/hardware-configuration.nix` run the below instead.
```
sudo nixos-rebuild switch --flake .#<hostName> --impure
```

## Postinstall Setup:
This section covers various steps you might want to take after installing the system on your host. These step primaraly focus on making sure your Hyprland And Niri dot files are properly set up for your system.

### Hyprland Post Install Setup
When enabling Hyprland you can either bring your own dotfiles, or use the ones I provide with the flake. You can configure my included dots, or setup your own dots before building the system, however I find it easier to get all the information I need after the device has been built.

*Please note that due to the way I have built the flake, somethings like monitors & enviromental variables may not be host agnostic.* 
#### Using My Included Dotfiles
1. My dotfiles will need to be enabled on a user to user basis, so make sure to set the `hyprlandConfig.enable` option to `true`, for each user you want to use the config with.
2. Next, you will need to configure your monitors, run `hyprctl monitors` and make note of your monitor outputs for your displays ID (Ie `eDP-1` or `HDMI-A-1`). Then within the repo navigate to `nixConfig/modules/features/homemanager/dotFiles/hypr/config` and look for the `variables.lua` & `monitors.lua` file. In `variables.lua` set the values of the monitor variables you got to match your preffered display layout. Then you can configure your monitor settings in `monitors.lua` I also include the `hyprmon` package if you would like a tui way of controling your monitors settings.
3. If you have an nvida GPU you can find envirment variables related to them at `nixConfig/modules/features/homemanager/dotFiles/uwsm/env`(For UWSM managed sessions) and `nixConfig/modules/features/homemanager/hypr/config/environment.lua`. Uncomment the commented out lines, and they will ensure your Envirment is properly set up for NVIDIA based GPUs.
4. I also recommend settiung up any autostart applications  in the `autostart.lua` file, which is found in the same place as the `monitors.lua` file. Note: If ueing UWSM, you should use XDG-autostart https://wiki.archlinux.org/title/XDG_Autostart
5. My Hyprland config uses the scrolling layout by default. If you would like to change this see `hypr/config/decorations.lua`
6. To manage your workspaces see `hypr/config/workspaces.lua`. By default only the workspaces for the Primary Monitor are preconfigured ( Typically Monitor 1, though may be different depending on your monitor setup).
7. Lastly, rebuild your system, and the dotfiles will automaticly be added to the nixstore, and a symlink will connect them to the `~/.config` directory
#### Using Your Own Dotfiles
You have 2 options here:
1. Replace the dotfiles in the flake with your own. This allows you to automaticly enable your dot files in your user directories.
2. Copy your dotfiles to the `~/.config` directory for your users

- If you plan on adding your dots to the `~/.config` directory mannualy, make sure that the `hyprlandConfig.enable` option is set to `false`.
##### Replacing My dotfiles with your own.
1. Open the dot files directory, located at `nixConfig/modules/features/homemanager/dotFiles`. Then delete the contents of the `hypr/` directory, and if your using UWSM delete the contents of the `uwsm/` directory as well. 
2. Then copy and paste your configuration files into the `hypr/` and `uwsm/`(if using) directorys.
3. Lastly, rebuild the system and your dotfiles will be set up.

### Niri Post Install Setup
When enabling Niri you can either bring your own dotfiles, or use the ones I provide with the flake. You can configure my included dots, or setup your own dots before building the system, however I find it easier to get all the information I need after the device has been built.

*Please note that due to the way I have built the flake, somethings like monitors & enviromental variables may not be host agnostic.* 
#### Using My Included Dotfiles
1. My dotfiles will need to be neabled on a user to user basis, so make sure to set the `niriConfig.enable` option to `true`, for each user you want to use the config with.
2. Next you will need to configure your monitors. Navigate to `nixConfig/modules/features/homemanager/dotFiles/niri/cfg`. Inside you'll find `displays.kdl`. This file is were you'll configure your displays. By default it contains a catch all that will automaticly make your displays at their "preffered" scale and place each one to the right of the other. To see your displays, run `niri msg outputs` Follow this link here for configuring your displays: https://github.com/YaLTeR/niri/wiki/Configuration:-Outputs
3. Configure your autostart applications in `autostart.kdl`. See this link here: https://github.com/YaLTeR/niri/wiki/Configuration:-Miscellaneous#spawn-at-startup Niri also supports XDG-autostart applications, so you can configure them like here: https://wiki.archlinux.org/title/XDG_Autostart
4. Rebuild your system, and you will now have the dotfiles in your system.
#### Using Your Own Dotfiles
You have 2 options here:
1. Replace the dotfiles in the flake with your own. This allows you to automaticly enable your dot files in your user directories.
2. Copy your dotfiles to the `~/.config` directory for your users

- If you plan on adding your dots to the `~/.config` directory mannualy, make sure that the `niriConfig.enable` option is set to `false`.
##### Replacing My dotfiles with your own.
1. Open the dot files directory, located at `nixConfig/modules/features/homemanager/dotFiles`. Then delete the contents of the `niri/` directory
2. Then copy and paste your configuration files into the `niri/`
3. Lastly, rebuild the system and your dotfiles will be set up.