{
  description = "Modelio App";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      modelioUrl = "https://github.com/ModelioOpenSource/Modelio/releases/download/v5.4.1/modelio-open-source-5.4.1_amd64.deb";
      installDir = "modelio-install";
      startScript = pkgs.writeScript "start-modelio" ''
        #!/bin/bash        
        DEB_FILE="modelio.deb"
        DIR="${installDir}"
        EXE="$DIR/usr/lib/modelio-open-source5.4/modelio"

        echo "Validating Modelio..."

        if [ ! -f "$EXE" ]; then            
            if [ ! -f "$DEB_FILE" ]; then
                echo "Downloading Modelio..."
                curl -L -o "$DEB_FILE" "${modelioUrl}"
            fi

            echo "Extracting Modelio..."
            rm -rf "$DIR"
            dpkg -x "$DEB_FILE" "$DIR"            
        fi

        echo "Running Modelio..."
        
        chmod +x "$EXE"        
        exec "$EXE"
      '';

      modelio-fhs = pkgs.buildFHSEnv {
        name = "modelio-env";
        targetPkgs = pkgs: (with pkgs; [
          bash
          coreutils
          dpkg
          findutils
          gawk

          jdk17

          gtk3
          gtk2
          glib
          gsettings-desktop-schemas
          
          xorg.libX11
          xorg.libXtst
          xorg.libXext
          xorg.libXrender
          xorg.libXi
          xorg.libXcomposite
          xorg.libXcursor
          xorg.libXdamage
          xorg.libXfixes
          xorg.libXrandr
          
          freetype
          fontconfig
          zlib
          webkitgtk_4_1
          
          dbus
          libcanberra-gtk3
          alsa-lib
          at-spi2-atk
          at-spi2-core
          cairo
          pango
          gdk-pixbuf
          
          libsecret
          libnotify
          nss
          nspr
          udev
        ]);

        
        runScript = startScript;
      };
    in
    {
      devShells.${system}.default = modelio-fhs.env;
    };
}
