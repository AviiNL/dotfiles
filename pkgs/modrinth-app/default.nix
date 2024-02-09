# https://modrinth.com/app
{ lib, stdenvNoCC, fetchurl, dpkg, autoPatchelfHook, wrapGAppsHook, gtk3
, webkitgtk, glib-networking, openssl_1_1, jdk17, openal, libpulseaudio, libGL
, flite }:
stdenvNoCC.mkDerivation rec {
  pname = "modrinth-app";
  version = "0.6.3";

  src = fetchurl {
    url =
      "https://launcher-files.modrinth.com/versions/${version}/linux/${pname}_${version}_amd64.deb";
    hash = "sha256-RT5y36r/nm90IkInvCwNW7Zv9LQk90ff/rtegPBEmyw=";
  };

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x $src .
    runHook postUnpack
  '';

  nativeBuildInputs = [ dpkg autoPatchelfHook wrapGAppsHook ];
  buildInputs = [ gtk3 webkitgtk glib-networking openssl_1_1 libGL flite ];

  installPhase = ''
    runHook preInstall
    mv -v usr $out
    runHook postInstall
  '';

  preFixup = ''
    gappsWrapperArgs+=(
      --prefix PATH : ${lib.makeSearchPath "bin/java" [ jdk17 ]}
      --set LD_LIBRARY_PATH ${
        lib.makeLibraryPath [ openal libpulseaudio libGL ]
      }
    )
  '';
}
