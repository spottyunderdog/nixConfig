{ ... }: {
  flake.homeModules.jdks = { pkgs, ... }: {
    home.file = {
      ".jdks/jdk25".source  = "${pkgs.jdk25}/lib/openjdk";
      ".jdks/temurin-bin-26".source = "${pkgs.temurin-bin-26}";
      ".jdks/jdk21".source = "${pkgs.jdk21}/lib/openjdk";
    };
  };
}