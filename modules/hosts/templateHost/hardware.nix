{ self, inputs, ... }: {

  flake.nixosModules.exampleHardware = { config, lib, pkgs, modulesPath, ... }: {

    # This is where your hardware configuration goes.
    # Paste the contents of your hardware-configuration.nix file here
    # (Paste the insids of the module, or delete the module thats being made here
    # and replace it with the module that contains your hardware config.)
    # See the DrNix Configuration to see an example of this.
    # Your hardware-configuration.nix should be found in /etc/nixos
    };

}