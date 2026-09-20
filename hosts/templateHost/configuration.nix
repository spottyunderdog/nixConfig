{ self, inputs, ... }:
let

  hostName = "templateHost";

in {

  flake.nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {

    modules = [ self.nixosModules."${hostName}Configuration" ];

  };

  flake.nixosModules."${hostName}Users" = { config, pkgs, ... }: {

    # Import User Configurations Here
    # User modules should follow the format of self.nixosModules."userName"
    imports = [
      self.nixosModules."nix"
    ];

  };

  flake.nixosModules."${hostName}Hardware" = { config, lib, pkgs, modulesPath, ... }: {
    # Use your own hardware configuration found in the /etc/nixos dir.
    # If you want to use this, make sure to add the --impure flag to the rebuild command, as this will use the hardware-configuration.nix file from your system.
    imports = [ /etc/nixos/hardware-configuration.nix ];

    # This is where your hardware configuration goes.
    # Paste the contents of your hardware-configuration.nix file here
    # (Paste the insids of the module, or delete the module thats being made here
    # and replace it with the module that contains your hardware config.)
    # See the DrNix Configuration to see an example of this.
    # Your hardware-configuration.nix should be found in /etc/nixos
  };

  flake.nixosModules."${hostName}Configuration" = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.packages
      self.nixosModules.systemSettings
      self.nixosModules."${hostName}Hardware"
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
    # nix-vars.hostname stores the hostname for use
    # in the auto upgrade service.
    networking.hostName = hostName;
    nix-vars.hostname = hostName;

    # Where you have installed the repository on
    # your host
    nix-vars.install-dir = "/etc/nixos";

    # Firewall Ports, Make sure these are
    # not made public as showing what ports are open
    # is a security risk
    # nix-vars.allowedTcp = [ ];
    # nix-vars.allowedTcpRanges = [ ];
    # nix-vars.allowedUdp = [ ];
    # nix-vars.allowedUdpRanges = [ ];

    # SSH Settings
    openSSH.enable = false;
    # Ports Open SSH SHould use
    # Don't publicly disclose your ssh ports, and it is typicly
    # a good idea to change it from the default port 22
    # as it is a commonly tested attack vecotor
    # nix-vars.ssh-ports = [ ];
    # Users Allowed to connect to system
    # nix-vars.allowed-ssh-users = [ "" ];
    # Aditional SSH Client Configurations ie hosts, etc
    # sshClient.config = "";

    # Enable swap file,
    # Swap Is required for hibernation
    swap.enable = false;
    # Size of the swap file, in GiB
    #nix-vars.swap-size = 32;
    # Zswap, not recommended to use with 
    zswap.enable = false;
    # Zram swap. not recommended to use with zswap
    zram.enable = false;

    # Enable Hibernation, Swap is required.
    hibernation.enable = false;

    # Enable Automatic garbage collection
    auto-garbage-collection.enable = false;

    # Enable Automatic updates
    auto-update.enable = false;

    ################
    # Boot Loaders #
    ################

    # Bootloaders are incompatable with each other
    # Only have one enabled at a time.
    # I recommend using Limine if you are
    # Plannning on enabling secure boot on your system.

    # Grub Bootloader
    grub.enable = true;

    # Limine  Bootloader
    limine.enable = false;
    # Adds the efi fallback boot option to your limine boot options
    # You can also add other oses like, windows, here
    nix-vars.limine-entries = lib.mkForce ''
      /+Other systems and bootloaders
      //Efi Fallback
        protocol: efi
        path: boot():/EFI/BOOT/BOOTX64.EFI
    '';

    ##########################################
    # Desktop Environments + Display Manager #
    ##########################################

    # Flake contains a small suite of DEs and WMs to choose from
    # DEs are: Gnome, KDE Plasma (Wayland), and XFCE
    # WMs are: Hyprland + Noctalia Shell, and Niri + Noctalia Shell

    
    # Default login manager is SDDM, themed with the silent SDDM theme,
    # With the "rei" styling. you can find them here:
    # https://github.com/uiriansan/SilentSDDM
    sddm.enable = true;
    silentSDDM.enable = true;
    silentSDDM.theme = "rei";


    gnome.enable = false;
    hyprland.enable = false;
    kde-plasma.enable = true;
    niri.enable = false;
    xfce.enable = false;


    #####################
    # KERNEL MANAGEMENT #
    #####################

    # ONLY ONE KERNEL CAN BE USED AT ONCE
    # CONFIGURATION WILL FAIL TO COMPILE IF YOU USE
    # MORE THEN ONE

    # Use the default nixos kernel
    linux-nix-default-kernel.enable = true;

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

    # Omniflake can be up to 8 days behind the master branch of the nix-cachyos-kernels
    # flake. Use if you don't mind being behind on the latest version of the cachyos kernel
    cachyos-kernel-overlay.omniflakeEnable = false;

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
    cachyos-latest-kernel-zen4.enable = false;

    ############
    # Software #
    ############

    # All app Config files can be found at:
    # nixConfig/modules/features/apps
    # To enable specific app configs, IE hyprland or niri dotfiles
    # or shell aliases, enable them in your user's user.nix file.

    # Enable Flatpak support.
    # Installs Flatseal, and any other flatpaks
    # You specified in the flatpak.nix file
    flatpak.enable = true;

    # Enable a suite of apps that I see as nescasary for the
    # day to day use of a system. Think webbrowers, etc.
    # See the needed-packages.nix for the full list
    needed-packages.enable = true;

    # Enable some comunication apps, ie discord, whatsapp
    # See coms-packages.nix for full list
    coms-packages.enable = false;

    # Enable some apps that can be used for devlopment, like VS Code, or Eclipse IDE (Java)
    # See dev-packages.nix for full list
    dev-packages.enable = false;

    # Enable apps used for editing like handbrake and kdenlive
    # See editing-packages.nix for full list
    editing-packages.enable = false;

    # Enable some apps used for gaming, like Steam, Prism Launcher and Lutris
    # See gaming-packages.nix for full list
    gaming-packages.enable = false;

    # Enable some media apps, like VLC and Jellyfin
    # See media-packages.nix for full list
    media-packages.enable = false;

    # Enable apps used for remote access, like sunshine/moonlight, and tailscale
    # see remote-access-packages.nix for full list
    remote-access-packages.enable = false;

    # Enable some utility apps like Btop, easyeffects, and filelight
    # See utilityApps.nix for full list
    utility-packages.enable = true;

    # Enables The ZSH & Fish shells
    extra-shells.enable = true;

    # Enables apps by Proton, IE protonVPN, mail, & pass
    proton-packages.enable = false;

    ################
    # Alt Browsers #
    ################

    # Zen Browser ( Requires Flatpaks to be enabled )
    zen.enable = false;

    # Vivaldi Browser
    vivaldi.enable = false;

    #################
    # Office Suites #
    #################

    # Libre Office
    libre-office.enable = false;
    
    # Obsidian (Note Taking Software)
    obsidian.enable = false;

    ####################################################
    # Apps used to theme other apps or replacment apps #
    # That can be used for extra theming.              #
    ####################################################

    # Used to install steam Homebrew, like themes, etc
    millennium.enable = false;

    # Alternitive discord client, can be customized beyond regular discord
    vesktop.enable = false;

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
    vmware.enable = false;

    # Enable Oracle Virtual Box, For VM Management
    virtualbox.enable = false;

    # Enable Virtual Machine Manager, For manage QEMU Virtual Machines
    virt-manager.enable = false;

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

    nvidia-drivers.enable = false; # Nvidia Gpus
    amd-drivers.enable = false; # Amd Gpus
    intel-drivers.enable = false; # Intel Gpus

    ####################################
    # NVIDIA PRIME, DUAL-GPU Setups    #
    # Ie: Intel/Amd iGPU + Nvidia dGPU #
    ####################################

    # Uncomment below and follow the wiki for setting it
    # Up for your computer. https://nixos.wiki/wiki/Nvidia

    # hardware.nvidia.prime = {
    #  Prime Offload, Incompatible with Prime Sync
    #  Prime offload means the gpus only active when requested,
    #  Sync Means the dGPU is always active.
    #  offload = {
    #    enable = true;
    #    enableOffloadCmd = true;
    #  };
    # Bus IDs for the Nvidia and AMD GPUs.
    # Replace these with your own GPU's bus IDs.
    # Enable the bus id for the GPU + iGPU combination you have.
    #  nvidiaBusId = "PCI:1:0:0";
    #  amdgpuBusId = "PCI:199:0:0";
    #  intelBusId = "PCI:0:2:0";
    # };

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
      # gaming-time.configuration = {
      #   hardware.nvidia.prime.sync.enable = lib.mkForce true;
      #   hardware.nvidia.prime.offload = {
      #     enable = lib.mkForce false;
      #     enableOffloadCmd = lib.mkForce false;
      #   };

      # };

    };

  };

}
