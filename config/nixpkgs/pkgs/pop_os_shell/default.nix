{ stdenv, lib, fetchFromGitHub, nodePackages, glib, substituteAll, gjs }:

stdenv.mkDerivation rec {
  pname = "pop-os-shell";
  version = "1.2.0-head";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "shell";
    rev = "15e7acfc8d9e52389b251b22e2e596e39607ac2f";
    sha256 = "sha256-SlVXFJyfhchQGv3D3InvMvNe4TNBdTtz8QhPFTAyB40=";
  };

  nativeBuildInputs = [ glib nodePackages.typescript gjs ];

  buildInputs = [ gjs ];

  # patches = [ ./fix-gjs.patch ];

  makeFlags = [
    "INSTALLBASE=$(out)/share/gnome-shell/extensions PLUGIN_BASE=$(out)/share/pop-shell/launcher"
    "XDG_DATA_HOME=$(out)/share"
    "DESTDIR=$(out)"
  ];

  postInstall = ''
    chmod +x $out/share/gnome-shell/extensions/pop-shell@system76.com/floating_exceptions/main.js
    chmod +x $out/share/gnome-shell/extensions/pop-shell@system76.com/color_dialog/main.js
  '';

  meta = with lib; {
    description = "Keyboard-driven layer for GNOME Shell";
    license = licenses.gpl3Only;
    homepage = "https://github.com/pop-os/shell";
    platforms = platforms.linux;
    # maintainers = with maintainers; [ remunds ];
  };
}
