{ self, inputs, ... }:

let

  userName = "spotty";

in {

  flake.nixosModules."users-${userName}" = { config, pkgs, lib, ... }: {

    # Define a user account. Don't forget to set a password with ‘passwd’
    users.users.${userName} = {
      isNormalUser = true;
      description = userName;

      extraGroups = [ "networkmanager" "wheel" ]
      ++ lib.optional config.virtManVMs.enable "libvirtd"
      ++ lib.optional config.virtualboxVMs.enable "vboxusers";

      shell = pkgs.fish;

      packages = with pkgs; [
        #  thunderbird
      ];
    };

    home-manager.users.${userName} = self.homeModules."${userName}Module";

  };

  flake.homeConfigurations.${userName} = inputs.home-manager.lib.homeManagerConfiguration {

    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };

    modules = [
      self.homeModules."${userName}Module"
      {
        home.username = userName;
        home.homeDirectory = "/home/${userName}";
      }
    ];

  };

  flake.homeModules."${userName}Module" = { pkgs, ... }: {

    imports = [
      self.homeModules.appConfigs
    ];

    xdg.configFile."fontconfig/conf.d/10-hm-fonts.conf".force = true;

    zedConfig.enable = true;
    bashConfig.enable = true;
    fishConfig.enable = true;
    zshConfig.enable = true;
    starshipConfig.enable = true;
    niriConfig.enable = true;
    hyprlandConfig.enable = true;

    home.packages = [ ];
    home.stateVersion = "26.05";

  };

}
