require 'package'

class Libxres < Package
  description 'X.org X-Resource extension client library'
  homepage 'https://www.x.org/wiki/'
  version '1.2.2'
  license 'X11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxres.git'
  git_hashtag "libXres-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85692a6d926c0b22a9253c1bf2c3b58d95a6b522a910879bfe77244499888aa7',
     armv7l: '85692a6d926c0b22a9253c1bf2c3b58d95a6b522a910879bfe77244499888aa7',
     x86_64: '85c68ffd68dd2dbc642d555f68cd2513e94cb7888ca25f248b49bcfad71651f5'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
