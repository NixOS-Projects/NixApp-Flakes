{
  description = "Android Studio";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "android-dev-shell";

        buildInputs = with pkgs; [
          android-studio
          jdk17          
        ];

        shellHook = ''
          export JAVA_HOME=${pkgs.jdk17}         
          android-studio && exit
        '';
      };
    };
}
