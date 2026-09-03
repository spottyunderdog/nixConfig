{ self, inputs, ... }:
let

  hostName = "drNix";

in {

  flake.nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {

    modules = [ self.nixosModule."${hostName}Configuration" ];

  };

  flake.nixosModules."${hostName}Users" = { config, pkgs, ... }: {

    imports = [
      # Import User Configurations Here
      # User modules should follow the format of self.nixosModules."<hostname>-<username>"
      self.nixosModules."${hostName}-nix"
    ];

  };

  flake.nixosModules."${hostName}Hardware" = { config, lib, pkgs, modulesPath, ... }: {

    imports = [ 
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = { 
      device = "/dev/disk/by-uuid/ea34ee39-8687-4824-8621-de5d82b78152";
      fsType = "btrfs";
    };

    fileSystems."/home" = { 
      device = "/dev/disk/by-uuid/ea34ee39-8687-4824-8621-de5d82b78152";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/ea34ee39-8687-4824-8621-de5d82b78152";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/BD56-491A";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };

  flake.nixosModule."${hostName}Configuration" = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.packages
      self.nixosModules.homeManager
      self.nixosModules.systemSettings
      # Module for hardware settings
      self.nixosModules."${hostName}Hardware"
      # module for host specific users, each host needs its own name
      # name should be self.nixosModules.<host name>Users
      self.nixosModules."${hostName}Users"
      # If you want to use the same user account accross different hosts
      # leave the module uncommented. Their config files are found at
      # nixConfig/modules/sharedsystemConfigs/users
      # self.nixosModules.crossSystemUsers
    ];

    ############################
    # Device Specific Settings #
    ############################

    # All settings bellow are configured on a device to device basis
    # for system settings used across different hosts go to the
    # nixConfig/modules/sharedSystemConfigs,
    # There you can configure the bootloader, hibernation, locale,
    # pipewire, swap, kernelss, display manager, desktop envirments, and any users you want
    # to be able to use accross different hosts.

    # Configure Host Name
    networking.hostName = hostName;

    # Enable swap (This specificly enables ZSwap),
    # Swap Is required for hibernation, can be ignored
    # If swap is enabled in your hardware config.
    swap.enable = true;

    # Enable Hibernation, Swap is required.
    hibernation.enable = true;

    # Enable Automatic garbage collection
    autoGarbageCollection.enable = true;

    #######################
    # Desktop Environments #
    #######################

    # Flake contains a small suite of DEs and WMs to choose from
    # DEs are: Gnome, KDE Plasma (Wayland), and XFCE
    # WMs are: Hyprland + Noctalia Shell, and Niri + Noctalia Shell

    # Gnome uses GDM As the display manager, and comes with the PaperWM
    # Shell extension if you would like to use scrolling window management
    # Within a more tradition DE
    gnome.enable = false;

    # All Other DEs and WMs use SDDM as the display manager
    # SDDM uses the SilentSDDM theme, with the "rei" preset
    # To disable the Theme or change the Silent SDDM Preset
    # see the displayManger.nix file (Located at
    # nixConfig/modules/features/sharedSystemConfigs/sessionManagement)
    hyprland.enable = false;
    kdePlasma.enable = true;
    niri.enable = true;
    xfce.enable = true;


    #####################
    # KERNEL MANAGEMENT #
    #####################

    # ONLY ONE KERNEL CAN BE USED AT ONCE
    # CONFIGURATION WILL FAIL TO COMPILE IF YOU USE
    # MORE THEN ONE

    # Use the default nixos kernel
    linuxKernelNixDefault.enable = false;

    # Use the latest linux kernel
    linuxLatestKernel.enable = false;

    # Use the 6.12 Linux Kernel (LTS Kernel)
    linuxKernel6_12.enable = false;

    # Use the 6.18 Linux Kernel (LTS Kernel)
    linuxKernel6_18.enable = false;

    ###################################
    # Cachy OS Optimize Linux Kernels #
    ###################################

    # These are the kernels made by the CachyOS
    # Team, and contain hardware optimizations to
    # Help improve performance.
    # Read more here: https://wiki.cachyos.org/cachyos_basic/why_cachyos/

    # Included in this flake are the Server, Harded, Latest, and Latest LTS kernels
    # Latest And LTS have architechture specific varients, that i have included modules
    # If you want to specify the one you want, If you don't know which you should use
    # Read here: https://wiki.cachyos.org/features/optimized_repos/
    # Or use the module that doesn't specify the specific architecture.
    # Architectures provided are: Zen4, x86v3, and x86v4
    # Note: Zen 4 should work for both zen 4 and zen 5 cpus if i'm reading their wiki correctly.

    # CachyOS Server Kernel
    cachyServerKernel.enable = false;

    # Cachy Hardened Kernel
    cachyHardenedKernel.enable = false;

    # Cachy LTS Kernels
    cachyLtsKernel.enable = false;
    cachyLtsKernel-x86v3.enable = false;
    cachyLtsKernel-x86v4.enable = false;
    cachyLtsKernel-zen4.enable = false;

    # Cachy OS Latest Kernels
    cachyLatestKernel.enable = false;
    cachyLatestKernel-x86v3.enable = false;
    cachyLatestKernel-x86v4.enable = false;
    cachyLatestKernel-zen4.enable = true;

    ############
    # Software #
    ############

    # All app Config files can be found at:
    # nixConfig/modules/features/apps
    # To enable specific app configs, IE hyprland or niri dotfiles
    # or shell aliases, enable them in your user's user.nix file.
    # Found at either
    # nixConfig/modules/sharedSystemConfigs/users or
    # nixConfig/modules/hosts/<host-name>/users

    # Enable Flatpak support.
    # Installs Flatseal, and any other flatpaks
    # You specified in the flatpak.nix file
    flatpak.enable = true;

    # Enable a suite of apps that I see as nescasary for the
    # day to day use of a system. Think webbrowers, etc.
    # See the neededApps.nix for the full list
    neededApps.enable = true;

    # Enable some comunication apps, ie discord, whatsapp
    # See comsApps.nix for full list
    comsApps.enable = true;

    # Enable some apps that can be used for devlopment, like VS Code, or Eclipse IDE (Java)
    # See devApps.nix for full list
    devApps.enable = true;

    # Enable apps used for editing like handbrake and kdenlive
    # See editingApps.nix for full list
    editingApps.enable = true;

    # Enable some apps used for gaming, like Steam, Prism Launcher and Lutris
    # See gamingApps.nix for full list
    gamingApps.enable = true;

    # Enable some media apps, like VLC and Jellyfin
    # See mediaApps.nix for full list
    mediaApps.enable = true;

    # Enable apps used for remote access, like sunshine/moonlight, and tailscale
    # see remoteAccess.nix for full list
    remoteAccessApps.enable = true;

    # Enable some utility apps like Btop, easyeffects, and filelight
    # See utilityApps.nix for full list
    utilityApps.enable = true;

    # Enables The ZSH & Fish shells
    extraShells.enable = true;

    # Enables apps by Proton, IE protonVPN, mail, & pass
    protonApps.enable = true;

    ################
    # Alt Browsers #
    ################

    # Zen Browser ( Requires Flatpaks to be enabled )
    zen.enable = true;

    # Vivaldi Browser
    vivaldi.enable = true;

    ####################################################
    # Apps used to theme other apps or replacment apps #
    # That can be used for extra theming.              #
    ####################################################

    # Required to enable the apps that are used to for
    # extra customization
    extraCosmetics.enable = true;

    # Used to install steam Homebrew, like themes, etc
    millennium.enable = true;

    # Alternitive discord client, can be customized beyond regular discord
    vesktop.enable = true;

    #########################################################################
    # Other applications that you may want on the host, but aren't included #
    # in the above modules.                                                 #
    #########################################################################
    environment.systemPackages = with pkgs; [
        #  thunderbird
    ];

    ###########################
    # Virtualization Software #
    ###########################

    # Enable Vmware Workstation, For VM management
    vmwareVMs.enable = true;

    # Enable Oracle Virtual Box, For VM Management
    virtualboxVMs.enable = true;

    # Enable Virtual Machine Manager, For manage QEMU Virtual Machines
    virtManVMs.enable = true;

    # Docker and Podman have yet to be implemented.
    # Though they are planned to be added once i figure out
    # how to get them set up.

    ####################
    # Graphics Drivers #
    ####################

    # These are dependent on your system enable based on what you need

    nvidiaDrivers.enable = true; # Nvidia Gpus
    amdDrivers.enable = true; # Amd Gpus
    intelDrivers.enable = false; # Intel Gpus

    ####################################
    # NVIDIA PRIME, DUAL-GPU Setups    #
    # Ie: Intel/Amd iGPU + Nvidia dGPU #
    ####################################

    # Uncomment below and follow the wiki for setting it
    # Up for your computer. https://nixos.wiki/wiki/Nvidia

    hardware.nvidia.prime = {
      # Prime Offload, Incompatible with Prime Sync
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Bus IDs for the Nvidia and AMD GPUs.
      # Replace these with your own GPU's bus IDs.
      nvidiaBusId = "PCI:1@0:0:0";
      amdgpuBusId = "PCI:199@0:0:0";
      # intelBusId = "PCI:0@0:2:0"; # Uncomment if using Intel + Nvidia hybrid graphics instead of AMD + Nvidia.
    };
    ####################
    # Networking stuff #
    ####################

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

  };

}
