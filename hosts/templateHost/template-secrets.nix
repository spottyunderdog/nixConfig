{ self, inputs, ... }: {

  flake.nixosModules.template-secrets = { ... }: {

    # Set up any Sops secret inports here
    # Ignore this file if your not using
    # or don't have any need for secrets management
    # it is recommended to 

  };

}