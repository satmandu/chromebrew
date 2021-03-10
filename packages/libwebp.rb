require 'package'

class Libwebp < Package
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '1.2.0-2'
  compatibility 'all'
  source_url 'http://downloads.webmproject.org/releases/webp/libwebp-1.2.0.tar.gz'
  source_sha256 '2fc8bbde9f97f2ab403c0224fb9ca62b2e6852cbc519e91ceaa7c153ffd88a0c'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.2.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.2.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.2.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.2.0-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0f533394a4dc99341aee73d01137340712a7c53d6c2d356b301be02e044f1b21',
     armv7l: '0f533394a4dc99341aee73d01137340712a7c53d6c2d356b301be02e044f1b21',
       i686: '466264dba3927e1ef045144aeba01ad5c132336eb0f9e9c4695529abad14ad04',
     x86_64: '3fdc15918aad6ad2ba36929b9ba7b39dd59750b114b0fb96b9bb31d030a1b4e4'
  })

  depends_on 'giflib'
  depends_on 'libjpeg_turbo'
  depends_on 'libpng'
  depends_on 'libsdl'
  depends_on 'libtiff'
  depends_on 'mesa'

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-libwebpmux \
      --enable-libwebpdemux \
      --enable-libwebpdecoder \
      --enable-libwebpextras \
      --enable-sdl \
      --enable-tiff \
      --enable-jpeg \
      --enable-png \
      --enable-gif"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
