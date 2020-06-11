{ stdenv, buildPythonPackage, fetchgit, pkgconfig, lxml, libvirt, nose }:

buildPythonPackage rec {
  pname = "libvirt";
  version = "6.4.0";

  src = assert version == libvirt.version; fetchgit {
    url = "git://libvirt.org/libvirt-python.git";
    rev = "v${version}";
    sha256 = "0qzi6948ijal2wgv0v4b769n7qxxcwgrq2vv1ddf860qvb0wpn4l";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libvirt lxml ];

  checkInputs = [ nose ];
  checkPhase = ''
    nosetests
  '';

  meta = with stdenv.lib; {
    homepage = "http://www.libvirt.org/";
    description = "libvirt Python bindings";
    license = licenses.lgpl2;
    maintainers = [ maintainers.fpletz ];
  };
}
