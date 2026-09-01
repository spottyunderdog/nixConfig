# Host Options

## Generic

| Option                       | Default Value | Declaration in templateHost                      | Function                                                                                     |
| ---------------------------- | ------------- | ------------------------------------------------ | -------------------------------------------------------------------------------------------- |
| networking.hostName          | N/a           | \<hostName\> variable in hosts configuration.nix | Name for the computer/host.                                                                  |
| swap.enable                  | false         | false                                            | Enables ZSwap when set to true. Needed for hibernation.                                      |
| hibernation.enable           | false         | false                                            | Enables hibernation                                                                          |
| autoGarbageCollection.enable | false         | false                                            | Enable automatic garbage collection. Tells system to automaticly remove old generations, etc |

## Desktop Enviormnet / Window Manager

| Option           | Default Value | Declaration in templateHost | Function                                                 |
| ---------------- | ------------- | --------------------------- | -------------------------------------------------------- |
| gnome.enable     | false         | false                       | Enabling the GNOME DE                                    |
| hyprland.enable  | false         | false                       | Enables the Hyprland compositer with the noctalia shell. |
| kdePlasma.enable | false         | true                        | Enables the KDE Plasma DE                                |
| niri.enable      | false         | false                       | Enables the Niri Compositer with the Nocatalia shell.    |
| xfce.enable      | false         | false                       | Enable the XFCE Desktop Enviornment                      |
## Kernel Management
**IMPORTANT:** only one kernel can be enabled at a time!
### Linux Kernels

| Option                       | Default Value | Declaration in templateHost | Function                                   |
| ---------------------------- | ------------- | --------------------------- | ------------------------------------------ |
| linuxKernelNixDefault.enable | false         | true                        | Use the default NixOS kernel               |
| linuxLatestKernel.enable     | false         | false                       | Use the Latest release of the Linux kernel |
| linuxKernel16_12.enable      | false         | false                       | Use the 6.12 (LTS) Version of the Kernel   |
| linuxKernel6_18.enable       | false         | false                       | Use the 6.18 (LTS) Version of the Kernel   |
### CachyOS Kernels
CachyOS has made some optimizations to the linux kernel to help improve performance, so i decided to bundle them in. The Latest And LTS kernels come with archtechture specific build versions, so if you want to specify that specific verision you can. If you don't know what version you should use use the option that doesn't specify the architechture, ie the ones that don't end in x86v3/4 or zen4 I recommend giving these to articles from the CachyOS Wiki a read:
[Why CachyOS?](https://wiki.cachyos.org/cachyos_basic/why_cachyos/)
[Optimized Repos](https://wiki.cachyos.org/features/optimized_repos/)

| Option                         | Default Value | Declaration in templateHost | Function                                                |
| ------------------------------ | ------------- | --------------------------- | ------------------------------------------------------- |
| cachyServerKernel.enable       | false         | false                       | Enable CachyOS's server kernel                          |
| cachyHardenedKernel.enable     | false         | false                       | Enable CachyOS's hardened Kernel                        |
| cachyLtsKernel.enable          | false         | false                       | Enable CachyOS's LTS Kernel                             |
| cachyLtsKernel-x86v3.enable    | false         | false                       | Enable CachyOS's LTS Kernel for x86v3 CPUs              |
| cachyLtsKernel-x86v4.enable    | false         | false                       | Enable CachyOS's LTS Kernel for x86v4 CPUs              |
| cachyLtsKernel-zen4.enable     | false         | false                       | Enable CachyOS's LTS Kernel for Zen 4/5 CPUs            |
| cachyLatestKernel.enable       | false         | false                       | Enable CachyOS's Latest Kernel Release                  |
| cachyLatestKernel-x86v3.enable | false         | false                       | Enable CachyOS's Latest Kernel Release for x86v3 CPUs   |
| cachyLatestKernel-x86v4.enable | false         | false                       | Enable CachyOS's Latest Kernel Release for x86v4 CPUs   |
| cachyLatestKernel-zen4.enable  | false         | false                       | Enable CachyOS's Latest Kernel Release for Zen 4/5 CPUs |

## Software

| Option                  | Default Value | Declaration in templateHost | Function                                                                                                                    |
| ----------------------- | ------------- | --------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| flatpak.enable          | false         | true                        | Enable Flatpak support and install packages in flatpak.nix                                                                  |
| neededApps.enable       | true          | true                        | Install apps i think are needed for daily use                                                                               |
| comsApps.enable         | false         | false                       | Install apps used for communication                                                                                         |
| devApps.enable          | false         | false                       | Install apps that can be used for development like VS Code or Eclipse Java IDE                                              |
| editingApps.enable      | false         | false                       | Install apps that can be used for video editing                                                                             |
| gamingApps.enable       | false         | false                       | Install apps used for gaming                                                                                                |
| mediaApps.enable        | false         | false                       | Install apps used for media playback                                                                                        |
| remoteAccessApps.enable | false         | false                       | Install apps used for remote access                                                                                         |
| utilityApps.enable      | true          | true                        | Install some usefull utility apps like BTOP                                                                                 |
| extraShells.enable      | false         | true                        | Enable the ZSH and Fish Shells                                                                                              |
| protonApps.enable       | false         | false                       | Install apps from the proton software suite.                                                                                |
| zen.enable              | false         | false                       | Install The Zen Browser (Flatpak)                                                                                           |
| vivaldi.enable          | false         | false                       | Install the vivaldi browser                                                                                                 |
| extraCosmetics.enable   | false         | false                       | Enable to add some apps that can integrate with the noctalia shells theming or allow for more themeable versions of the app |
| millennium.enable       | false         | false                       | Install the millenium steam hombrew. Allows for extra themeing and plugins in steam.                                        |
| vesktop.enable          | false         | false                       | Enables the alternative discord client vesktop, can be themed via noctalia, and other plugins.                              |
## Virtualization
Software that can be used for virtualization
*Planned VM and Container software*:
- Winboat
- Docker
- Podman

| Option               | Default Value | Declaration in Template Host | Function                                  |
| -------------------- | ------------- | ---------------------------- | ----------------------------------------- |
| vmwareVMs.enable     | false         | false                        | Enable Broadcomm's VMWare Workstation Pro |
| virtualboxVMs.enable | false         | false                        | Enable Orcale Virtual Box                 |
| virtManVms.enable    | false         | false                        | Enable virtual machine manager and QEMU   |
## Drivers

| Option               | Default Value | Declaration in Tempalate Host | Function                 |
| -------------------- | ------------- | ----------------------------- | ------------------------ |
| nvidiaDrivers.enable | false         | false                         | Enable NVIDA GPU Drivers |
| amdDrivers.enable    | false         | false                         | Enable AMD GPU Drivers   |
| intelDrivers.enable  | false         | false                         | Enable Intel GPU Drivers |


# User Options
These are the options that must be configured in each users .nix file. For example, the templateHost user nix lists these options in the nixUser.nix file.

| Option                | Default Value | Declaration in templateHost | Function                                                         |
| --------------------- | ------------- | --------------------------- | ---------------------------------------------------------------- |
| bashConfig.enable     | false         | false                       | Enables my bash config (requires utilityApps.enable = true)      |
| fishConfig.enable     | false         | false                       | Enable my fish config (requires utilityApps.enable = true)       |
| zshConfig.enable      | false         | false                       | Enables my zsh config (requires utilityApps.enable = true)       |
| starshipConfig.enable | false         | false                       | Enables my starship prompt config                                |
| niriConfig.enable     | false         | false                       | Enables my Niri + Noctalia Dotfiles                              |
| noctaliaConfig.enable | false         | false                       | Enables just my Noctalia Dotfiles                                |
| hyprlandConfig.enable | false         | false                       | Enables my Hyprland + Noctalia Dotfiles                          |
| zedConfig.enable      | false         | false                       | Enables my Zed Editor configuration                              |
| kittyConfig.enable    | false         | false                       | Enables my kitty configuration (best used with Hyprland or Niri) |
