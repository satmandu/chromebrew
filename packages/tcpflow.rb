require 'package'

class Tcpflow < Package
  description 'TCP/IP packet demultiplexer'
  homepage 'https://github.com/simsong/tcpflow'
  version '1.6.1-b1479db'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/simsong/tcpflow.git'
  git_hashtag 'b1479db14b1604e00d35c2d39566c54e8b1785d0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '13f7de4e37ae24a3969a87b8748e01fc6a5becd4f5c28c74fafcf9eaf3be4afb',
     armv7l: '13f7de4e37ae24a3969a87b8748e01fc6a5becd4f5c28c74fafcf9eaf3be4afb',
     x86_64: '21d9e46128c7c1d7767cf79c53448c7e989e308fcefa579f97f04debb35069de'
  })

  depends_on 'boost' => :build
  depends_on 'bzip2' # R
  depends_on 'cairo' => :build
  depends_on 'cairo' # R
  depends_on 'expat' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libcap_ng' # R
  depends_on 'libmd' # R
  depends_on 'libpcap' # R
  depends_on 'openssl' # R
  depends_on 'pixman' # R
  depends_on 'sqlite' # R
  depends_on 'zlib' # R

  def self.build
    system 'bash bootstrap.sh'
    system "./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install"
  end
end
