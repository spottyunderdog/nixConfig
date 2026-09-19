{ self, inputs, ... }: {

  flake.nixosModules.session-variables = { config, pkgs, lib, ... }: {

    environment.sessionVariables = rec {
      REPO_DIR = "${config.nix-vars.install-dir}/nixConfig";
    };

  };

}