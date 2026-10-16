# Nix Config

### **AI Disclosure**
Almost all the code here is written by me, however, I do you Claude, and occasionally ChatGPT to review my code.
Only 2 things (that I can remember), were generated with Claude/GPT and those are a Systemd service for my drNix config
(handles opening a secret ssh port in my firewall) and the sercurity.pam.sddm settings for ensuring wallet is opened

# About
Look my Configurations a mess, but it's my mess. I figure I'll explain some stuff here, like my design philosophy when
building the project (though at some points i most certainly broke said philosophy and have yet to bring it in line, I'm
looking at you maxdatafiles settings(this is a not to me, so I remember to bring that package in line with the rest))

## To Do List
1. move maxdatafiles from `software-modules/packages/packages.nix` to its own file and module
2. Update the `software-modules/home-manager/app-modules/jdks.nix` to have and enable option with default value tied to 
java.enable
3. Update the `software-modules/home-manager/gtk-config.nix` to have a `.enable` option. Defaults to `true`
4. Move any `nix-vars` options in the `variables/` directory to a corresponding module/file where reasonable.
5. Finish README.md

## Design Philosophy
1. Each module deels with the settings for its corresponding Software/Package/Program. If the program needs to add other
packages installed alongside it, only add those packages, if those packages need their own configuration, they go into
their own module, and that module gets enabled by the other module. Example of a module that has Multiple packages: Steam/Millenium
Shared since the configuration is for steam and the packages swap out; Ex: Dolphin, installs some extra packages to help
with network shares and other functionality
2. One Module Per file. All files (except for my configuration.nix file for hosts, and my user files) have 
one Module (flake.nixosModules.<name> or flake.homeModules.<name>). Each file should have that focused scope and do one
thing so that settings can be updated quicker. The exception is my configuration.nix files for host and my users-<name>.nix
files, because those use variable to allow me to more quickly update things like host name, or usernames and anything
tied to said name.
3. Modules in the `software-modules/` directory should all have `.enable` options for their software, to allow each
software configuration to be more quickly disabled if theirs a build error in it. Modules that serve ONLY to import the 
modules and set a default setting do not have to have a `.enable` option.
4. Modules in the `system-settings/` directory, that have a setting that may change from host to host, should have an
option for changing said setting IE: Extra Limine Boot entries, setting a specific Astronaut SDDM Theme Preset, etc.
5. Keep files/modules in appropriate places. IE: Hosts in the `hosts/` directory, users in the `user/` dir. Any host
specific or user specific modules should be kept in a directory for that host/user, and if needed subdirectories specifying
what they do.

## File Structure
Hopefully The file structure isn't too crazy but I'll still do a light breakdown from top down of each directorys purpose

### [documentation](documentation/)
Any written down file containing a list of stuff explaining my code. Mostly for myself, if i forget what something does
### [dot-files](dot-files/)
Where any program dotfiles, that are either too annoying to write declaritively, or i don't want to have to rebuild my
system any time i want to see a change, goes here. Inside it are
1. [extras](dot-files/extras): Some extra noctalia widget configurations for different host that i didn't add to my main
noctalia dots
2. [hypr](dot-files/hypr): My hyprland dot files.
3. [kitty](dot-files/kitty): My kitty dot files.
4. [niri](dot-files/niri): My niri dot files
5. [noctalia](dot-files/noctalia): My noctalia shell dot files
6. [uwsm](dot-files/uwsm): My UWSM dot files, used with hyprland.
### [hosts](hosts/)
Where I define and configure hosts. Currently 2 sub-directories:
1. [drNix](hosts/drNix): My Current Nixos machine's configuration files.
2. [templateHost](hosts/templateHost): A template host so i can quickly set up any new hosts.
### [secrets](secrets/)
Pretty self explainitory. its where any data that needs to be kept from public eyes are kept.
### [software-modules](software-modules/)
Pretty beefy one. Contains all settings for my home-manager, any packages i may use/want, and virtualization software
#### [home-manager](software-modules/home-manager)
1. [app-modules](software-modules/home-manager/app-modules): Any program specific home-manager configurations. IE zed-editor
or VSCode configs.
2. [dot-files-modules](software-modules/home-manager/dot-files-modules): Any modules for importing dotfiles from `dotfiles/`
3. [shells](software-modules/home-manager/): Shell specific configurations.
#### [packages](software-modules/packages)
1. []