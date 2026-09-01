{ self, inputs, ... }: {

  flake.nixosModules.drNixConfiguration = { config, pkgs, lib, ... }: {

    imports = [
        self.nixosModules.drNixHardware
        self.nixosModules.packages
        self.nixosModules.homeManager
        self.nixosModules.systemSettings
        self.nixosModules.crossSystemUsers
    ];

    # Host Name
    networking.hostName = "DrNixasauros";

    # Enable swap, Zswap is used by default
    swap.enable = true;

    # Enable hibernation, swap must be enabled for hibernation to work.
    hibernation.enable = true;

    # kernel
    cachyLatestKernel-zen4.enable = true;

    # Desktop Environment
    xfce.enable = true;
    kdePlasma.enable = true;
    niri.enable = true;

    # enable flatpaks
    flatpak.enable = true;

    # Enable Some Optional Packages:
    devApps.enable = true;
    gamingApps.enable = true;
    mediaApps.enable = true;
    neededApps.enable = true;
    remoteAccessApps.enable = true;
    utilityApps.enable = true;
    editingApps.enable = true;
    extraShells.enable = true;
    protonApps.enable = true;
    extraCosmetics.enable = true;
    millennium.enable = true;
    vesktop.enable = true;
    zen.enable = true;
    vivaldi.enable = true;

    # Enable Virtualization Software
    vmwareVMs.enable = true;
    virtManVMs.enable = true;
    virtualboxVMs.enable = true;

    # Enable automatic Garbage collection
    autoGarbageCollection.enable = true;


  

    # Graphics Drivers
    nvidiaDrivers.enable = true;
    amdDrivers.enable = true;

    # Enable Prime Offloading for hybrid graphics setups (Nvidia + AMD/Intel).
    # Read: https://nixos.wiki/wiki/Nvidia for more information on how to configure this properly.
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


    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

  };

}
