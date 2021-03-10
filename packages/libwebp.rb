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
    aarch64: 'f76080fd09b1ceb14b1b7aacc2984ac2a4bae0b499e4cba9959d751f3f174dda',
     armv7l: 'f76080fd09b1ceb14b1b7aacc2984ac2a4bae0b499e4cba9959d751f3f174dda',
       i686: 'c55bb0665af44bbe228ae5d2cce42b2061cb1c394da8cdd70f1f143542fff22f',
     x86_64: 'c57164afcfc86e140f25e7864b60777a10c039201b705dbfa236fb816702301d'
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
