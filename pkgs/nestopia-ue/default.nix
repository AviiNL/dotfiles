{ lib, stdenv, fetchFromGitHub, pkg-config, SDL2, alsa-lib, gtk3, makeWrapper
, libGLU, libGL, libarchive, libao, unzip, xdg-utils, libepoxy, gdk-pixbuf
, gnome, wrapGAppsHook, autoconf, autoconf-archive, automake, fltk, zlib }:

stdenv.mkDerivation rec {
  version = "1.52.0";
  pname = "nestopia-ue";

  src = fetchFromGitHub {
    owner = "0ldsk00l";
    repo = "nestopia";
    rev = "d897bfdc047bf6309b46c12073dd7f0373fb60ba";
    sha256 = "sha256-kd5hZ88fCLL8ysGMj7HsrSA7eCI5SL2xxiRXJiZqBZ8=";
  };

  # nondeterministic failures when creating directories
  enableParallelBuilding = false;

  hardeningDisable = [ "format" ];

  buildInputs = [
    autoconf
    autoconf-archive
    automake
    fltk
    SDL2
    libarchive
    zlib
    libGLU
    libGL
  ];

  nativeBuildInputs = [ pkg-config makeWrapper wrapGAppsHook unzip ];

  buildPhase = ''
    autoreconf -vif
    ./configure --prefix=$out
    make
  '';

  patches = [
    #(fetchpatch {
    #  url = "https://github.com/rdanbrook/nestopia/commit/f4bc74ac4954328b25e961e7afb7337377084079.patch";
    #  name = "gcc6.patch";
    #  sha256 = "1jy0c85xsfk9hrv5a6v0kk48d94864qb62yyni9fp93kyl33y2p4";
    #})
    # ./gcc6.patch
    # ./build-fix.patch
  ];

  installPhase = ''
    mkdir -p $out/{bin,share/nestopia}
    make install PREFIX=$out
  '';

  preFixup = ''
    for f in $out/bin/*; do
      wrapProgram $f \
        --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH:$out/share"
    done
  '';

  meta = {
    homepage = "http://0ldsk00l.ca/nestopia/";
    description = "NES emulator with a focus on accuracy";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ MP2E ];
    mainProgram = "nestopia";
  };
}
