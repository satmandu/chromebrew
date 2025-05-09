require 'package'

class Libvncserver < Package
  description 'LibVNCServer/LibVNCClient are cross-platform C libraries that allow you to easily implement VNC server or client functionality in your program.'
  homepage 'https://github.com/LibVNC/libvncserver'
  version '0.9.14'
  compatibility 'aarch64 armv7l x86_64'
  license 'GPL-2, GPL-2+, LGPL-2.1+, BSD and MIT'
  source_url "https://github.com/LibVNC/libvncserver/archive/LibVNCServer-#{version}.tar.gz"
  source_sha256 '83104e4f7e28b02f8bf6b010d69b626fae591f887e949816305daebae527c9a5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '640218d703bebf5bfbac3095018f559890dcfcfa5eeeafd5d74b933144124316',
     armv7l: '640218d703bebf5bfbac3095018f559890dcfcfa5eeeafd5d74b933144124316',
     x86_64: 'e91fe2d7c70cf4683379c57ef4c4ed63807226213b69d85015da72bf3e7e0037'
  })

  depends_on 'ffmpeg' => :build
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'gtk2' => :build
  depends_on 'libcyrussasl' # R
  depends_on 'libgcrypt' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'lzo' # R
  depends_on 'openssl' # R
  depends_on 'zlib' # R

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
        -DWITH_SYSTEMD=OFF \
        -Wno-dev \
        -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
