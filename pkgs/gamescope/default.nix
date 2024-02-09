{ stdenv, fetchFromGitHub, meson, pkg-config, ninja, xorg, libdrm, vulkan-loader
, vulkan-headers, wayland, wayland-scanner, wayland-protocols, libxkbcommon, glm
, gbenchmark, libcap, SDL2, pipewire, udev, pixman, libinput, seatd, xwayland
, glslang, hwdata, openvr, stb, wlroots, libavif, libliftoff, libdisplay-info
, lib, makeBinaryWrapper }:
let
  pname = "gamescope";
  version = "3.14.0";

  reshade = fetchFromGitHub {
    owner = "Joshua-Ashton";
    repo = "reshade";
    rev = "9fdbea6892f9959fdc18095d035976c574b268b7";
    hash = "sha256-kThWlcHcmf7kR0HuD0Zg2naCTi/nxEOu8U7Tr7WseXM=";
  };

  spirv-headers = fetchFromGitHub {
    owner = "KhronosGroup";
    repo = "SPIRV-Headers";
    rev = "d790ced752b5bfc06b6988baadef6eb2d16bdf96";
    hash = "sha256-OqLxyrTzg1Q2zmQd0YalWtl7vX5lRJFmE2VH7fHC8/8=";
  };

  # ====

  #   libdisplay-info = fetchFromGitHub { # 404
  #     owner = "KhronosGroup";
  #     repo = "SPIRV-Headers";
  #     rev = "d790ced752b5bfc06b6988baadef6eb2d16bdf96";
  #     hash = "sha256-OqLxyrTzg1Q2zmQd0YalWtl7vX5lRJFmE2VH7fHC8/8=";
  #   };

  #   libliftoff = { # 404
  #     owner = "KhronosGroup";
  #     repo = "SPIRV-Headers";
  #     rev = "d790ced752b5bfc06b6988baadef6eb2d16bdf96";
  #     hash = "sha256-OqLxyrTzg1Q2zmQd0YalWtl7vX5lRJFmE2VH7fHC8/8=";
  #   };

  #   openvr = fetchFromGitHub {
  #     owner = "ValveSoftware";
  #     repo = "openvr";
  #     rev = "15f0838a0487feb7da60acd39aab8099b994234c";
  #     hash = "sha256-UvhMhDqCJS5AhoZYf3mW558JebtBzNKpp6dbBntPUo0=";
  #   };

  vkroots = fetchFromGitHub {
    owner = "Joshua-Ashton";
    repo = "vkroots";
    rev = "d5ef31abc7cb5c69aee4bcb67b10dd543c1ff7ac";
    hash = "sha256-gNlSEeqy8svxrcUt1gYBacpjzdnfKS89yb//DiiCVTw=";
  };

  #   wlroots = { # 404
  #     owner = "KhronosGroup";
  #     repo = "SPIRV-Headers";
  #     rev = "d790ced752b5bfc06b6988baadef6eb2d16bdf96";
  #     hash = "sha256-OqLxyrTzg1Q2zmQd0YalWtl7vX5lRJFmE2VH7fHC8/8=";
  #   };

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "ValveSoftware";
    repo = "gamescope";
    rev = "refs/tags/${version}";
    hash = "sha256-uPx6yFIsELJ3ROPPlORvrbX5pLh9bDdtQOmxRJa0E3I=";
  };

  patches = [ ./use-pkgconfig.patch ];

  strictDeps = true;

  depsBuildBuild = [ pkg-config ];

  nativeBuildInputs =
    [ meson pkg-config ninja wayland-scanner glslang makeBinaryWrapper ];

  buildInputs = [
    xorg.libXdamage
    xorg.libXcomposite
    xorg.libXrender
    xorg.libXext
    xorg.libXxf86vm
    xorg.libXtst
    xorg.libXres
    xorg.libXi
    xorg.libXmu
    xorg.libXcursor
    libdrm
    libliftoff
    vulkan-loader
    vulkan-headers
    SDL2
    wayland
    wayland-protocols
    wlroots
    xwayland
    seatd
    libavif
    libinput
    libxkbcommon
    glm
    gbenchmark
    udev
    pixman
    pipewire
    libcap
    stb
    hwdata
    openvr
    vkroots
    libdisplay-info
  ];

  outputs = [ "out" "lib" ];

  postUnpack = ''
    rm -rf source/subprojects/vkroots
    ln -s ${vkroots} source/subprojects/vkroots

    rm -rf source/src/reshade
    ln -s ${reshade} source/src/reshade

    rm -rf source/thirdparty/SPIRV-Headers
    ln -s ${spirv-headers} source/thirdparty/SPIRV-Headers
  '';

  # --debug-layers flag expects these in the path
  postInstall = ''
    wrapProgram "$out/bin/gamescope" \
      --prefix PATH : ${with xorg; lib.makeBinPath [ xprop xwininfo ]}

    # Install Vulkan layer in lib output
    install -d $lib/share/vulkan
    mv $out/share/vulkan/implicit_layer.d $lib/share/vulkan
    rm -r $out/share/vulkan
  '';

  meta = with lib; {
    description = "SteamOS session compositing window manager";
    homepage = "https://github.com/ValveSoftware/gamescope";
    license = licenses.bsd2;
    maintainers = with maintainers; [ nrdxp pedrohlc Scrumplex zhaofengli ];
    platforms = platforms.linux;
  };
}
