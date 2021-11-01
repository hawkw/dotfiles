{ stdenv, lib, fetchFromGitHub, nodePackages, glib, substituteAll, gjs }:

stdenv.mkDerivation rec {
  pname = "pop-os-shell";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "shell";
    rev = "1fddaa8953a6554a83038bb5662662eb761eb361";
    sha256 = "1dc71iyxnb5cv9fb3sigdxdmc4dsmdz91djz1vwkbfw2csj8lzfg";
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
