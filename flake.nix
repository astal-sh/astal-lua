{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    astal.url = "github:astal-sh/libastal";
  };

  outputs = {
    self,
    nixpkgs,
    astal,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    lua = pkgs.lua.withPackages (ps: [
      ps.lgi
      (ps.luaPackages.toLuaModule (pkgs.stdenv.mkDerivation {
        name = "astal";
        version = "0.1.0";
        src = "${astal}/lua";
        dontBuild = true;
        installPhase = ''
          mkdir -p $out/share/lua/${ps.lua.luaversion}/astal
          cp -r astal/* $out/share/lua/${ps.lua.luaversion}/astal
        '';
      }))
    ]);

    nativeBuildInputs = with pkgs; [
      wrapGAppsHook
      gobject-introspection
    ];

    buildInputs = [
      lua
      astal.packages.${system}.default
    ];
  in {
    packages.${system} = {
      default = let
        script = pkgs.writeScript "astal-lua" ''
          #!${lua}/bin/lua
          package.path = package.path .. ";${./.}/?.lua"
          require "init"
        '';
      in
        pkgs.stdenv.mkDerivation {
          inherit nativeBuildInputs buildInputs;

          pname = "astal-lua";
          version = "0.1.0";
          src = ./.;

          installPhase = ''
            mkdir -p $out/bin
            cp -r * $out/bin
            cp ${script} $out/bin/astal-lua
            chmod +x $out/bin/astal-lua
          '';
        };
    };

    devShells.${system}.default = pkgs.mkShell {
      inherit nativeBuildInputs buildInputs;
    };
  };
}
