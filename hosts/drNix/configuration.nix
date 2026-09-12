{ self, inputs, ... }:
let

  hostName = "drNix";

in {

  flake.nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {

    modules = [ self.nixosModules."${hostName}Configuration" ];

  };

  flake.nixosModules."${hostName}Users" = { ... }: {

    imports = [
      # Import User Configurations Here
      # User modules should follow the format of self.nixosModules."<hostname>-<username>"
      self.nixosModules."${hostName}-spotty"
    ];

  };

  flake.nixosModules."${hostName}Hardware" = { config, lib, pkgs, modulesPath, ... }: {
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/da9c2d3d-5c75-42c1-a428-29cde9387dba";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/4075-60BF";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  flake.nixosModules."${hostName}Configuration" = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.packages
      self.nixosModules.systemSettings
      # Module for hardware settings
      self.nixosModules."${hostName}Hardware"
      # module for host specific users, each host needs its own name
      # name should be self.nixosModules.<host name>Users
      self.nixosModules."${hostName}Users"
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
    auto-garbage-collection.enable = true;

    # Bootloader
    # Grub
    grub.enable = false;
    # Limine
    limine.enable = true;
    nix-vars.limine-entries = lib.mkForce ''
      /+Other systems and bootloaders
      //Windows
        protocol: efi_chainload
        image_path: guid(dd177fac-1ef3-4e7c-aa35-d312e09a48fd):/efi/Microsoft/Boot/bootmgfw.efi
      //Efi Fallback
        protocol: efi
        path: boot():/EFI/BOOT/BOOTX64.EFI
    '';

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
    kde-plasma.enable = true;
    niri.enable = true;
    xfce.enable = false;


    #####################
    # KERNEL MANAGEMENT #
    #####################

    # ONLY ONE KERNEL CAN BE USED AT ONCE
    # CONFIGURATION WILL FAIL TO COMPILE IF YOU USE
    # MORE THEN ONE

    # Use the default nixos kernel
    linux-nix-default-kernel.enable = false;

    # Use the latest linux kernel
    linux-latest-kernel.enable = false;

    # Use the 6.12 Linux Kernel (LTS Kernel)
    linux-6_12-kernel.enable = false;

    # Use the 6.18 Linux Kernel (LTS Kernel)
    linux-6_18-kernel.enable = false;

    ###################################
    # Cachy OS Optimized Linux Kernels #
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

    # CachyOS Hardened Kernel 
    cachyos-hardened-kernel.enable = false;

    # CachyOS Server Kernel
    cachyos-server-kernel.enable = false;

    # Cachy LTS Kernels
    cachyos-lts-kernel.enable = false;
    cachyos-lts-kernel-x86v3.enable = false;
    cachyos-lts-kernel-x86v4.enable = false;
    cachyos-lts-kernel-zen4.enable = false;

    # Cachy OS Latest Kernels
    cachyos-latest-kernel.enable = false;
    cachyos-latest-kernel-x86v3.enable = false;
    cachyos-latest-kernel-x86v4.enable = false;
    cachyos-latest-kernel-zen4.enable = true;

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
    editingApps.enable = false;

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
    vivaldi.enable = false;

    libreOffice.enable = true;
    onlyOffice.enable = false;

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
        obsidian
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

    ##############
    # Containers #
    ##############

    # Docker
    docker.enable = false;

    # Podman
    # Podman will disable docker, regardless of if you enable
    # the above setting. Podman is configured to have docker compatability.
    podman.enable = false;
    


    ####################
    # Graphics Drivers #
    ####################

    # These are dependent on your system enable based on what you need

    nvidia-drivers.enable = true; # Nvidia Gpus
    amd-drivers.enable = true; # Amd Gpus
    intel-drivers.enable = false; # Intel Gpus

    ####################################
    # NVIDIA PRIME, DUAL-GPU Setups    #
    # Ie: Intel/Amd iGPU + Nvidia dGPU #
    ####################################

    # Uncomment below and follow the wiki for setting it
    # Up for your computer. https://nixos.wiki/wiki/Nvidia

    hardware.nvidia.prime = {
    #  Prime Offload, Incompatible with Prime Sync
    #  Prime offload means the gpus only active when requested,
    #  Sync Means the dGPU is always active.
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    # Bus IDs for the Nvidia and AMD GPUs.
    # Replace these with your own GPU's bus IDs.
    # Enable the bus id for the GPU + iGPU combination you have.
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:199:0:0";
    #  intelBusId = "PCI:0:2:0";
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

    ##################################
    # Specilizations for Host        #
    # IE, 2 different power modes etc#
    ##################################

    specialisation = {
      #### Exampple For different prime modes
      gaming-time.configuration = {
        hardware.nvidia.prime.sync.enable = lib.mkForce true;
        hardware.nvidia.prime.offload = {
          enable = lib.mkForce false;
          enableOffloadCmd = lib.mkForce false;
       };

     };

    };

  };

}
