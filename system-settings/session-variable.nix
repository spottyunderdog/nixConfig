{ self, inputs, ... }: {

  flake.nixosModules.session-variables = { config, pkgs, lib, ... }: {

    environment.variables = {
      REPO_DIR = "/home/spotty/nixConfig";
    };

  };

}