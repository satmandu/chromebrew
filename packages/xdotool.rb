# Adapted from Arch Linux xdotool PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/xdotool/trunk/PKGBUILD

require 'package'

class Xdotool < Package
  description 'Command-line X11 automation tool'
  homepage 'https://www.semicomplete.com/projects/xdotool/'
  version '3.20160805.1'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/jordansissel/xdotool/releases/download/v3.20160805.1/xdotool-3.20160805.1.tar.gz'
  source_sha256 '35be5ff6edf0c620a0e16f09ea5e101d5173280161772fca18657d83f20fcca8'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '37b9d630ca048ed377c184d44cbbc261022fabe6bec143abc0c066563f913bc4',
     armv7l: '37b9d630ca048ed377c184d44cbbc261022fabe6bec143abc0c066563f913bc4',
     x86_64: '4ed5c2e4c5b4dfde83c94c017ef7f37e601dc0252ad67341252b38b1a7b47cc2'
  })

  depends_on 'libxtst'
  depends_on 'libxinerama'
  depends_on 'libxkbcommon'

  def self.build
    system "PREFIX=#{CREW_PREFIX} INSTALLLIB=#{CREW_LIB_PREFIX} make WITHOUT_RPATH_FIX=1"
  end

  def self.install
    system "LDCONFIG=#{CREW_PREFIX}/sbin/ldconfig DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} INSTALLLIB=#{CREW_LIB_PREFIX} make install"
  end
end
