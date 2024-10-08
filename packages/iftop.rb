require 'package'

class Iftop < Package
  description 'iftop does for network usage what top(1) does for CPU usage.'
  homepage 'https://pdw.ex-parrot.com/iftop/'
  version '0.17'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://pdw.ex-parrot.com/iftop/download/iftop-0.17.tar.gz'
  source_sha256 'd032547c708307159ff5fd0df23ebd3cfa7799c31536fa0aea1820318a8e0eac'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '8c5c376a55f851adb4a0f189286445a67c9f51bceeada360e5c74c6d318a28ce',
     armv7l: '8c5c376a55f851adb4a0f189286445a67c9f51bceeada360e5c74c6d318a28ce',
       i686: '2136c6a3f6595c816ed758884a3410699f948f7cab07aace0861c6aad722f26d',
     x86_64: '3147fb82cbc3d6cbf1c4b6230894ff7347409bc9b733e2135c509a12dc2ea7f0'
  })

  depends_on 'libpcap'
  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} CPPFLAGS='-I#{CREW_PREFIX}/include/ncurses'"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
