{ stdenv, lib, fetchFromGitHub, nodePackages, glib, substituteAll, gjs }:

stdenv.mkDerivation rec {
  pname = "pop-os-shell";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "shell";
    rev = "522030336565badc6fd6068bd5e38328996aa4bf";
    sha256 = "0fx85wlnh1wdzrqi4ibih8ira0fvz5gmr6c3zh5fcrxdfj5p82z2";
  };

  nativeBuildInputs = [ glib nodePackages.typescript gjs ];

  buildInputs = [ gjs ];

  patches = [ ./fix-gjs.patch ];

  makeFlags = [
    "INSTALLBASE=$(out)/share/gnome-shell/extensions PLUGIN_BASE=$(out)/share/pop-shell/launcher"
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
