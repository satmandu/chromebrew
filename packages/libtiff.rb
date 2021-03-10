require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  @_ver = '4.2.0'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://download.osgeo.org/libtiff/tiff-#{@_ver}.tar.gz"
  source_sha256 'eb0484e568ead8fa23b513e9b0041df7e327f4ee2d22db5a533929dfc19633cb'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.2.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.2.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.2.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.2.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '692d843be36450b10ffe6371d703c7a99bfeb1ccf9f1c9cf82fa32a53c7b99f5',
     armv7l: '692d843be36450b10ffe6371d703c7a99bfeb1ccf9f1c9cf82fa32a53c7b99f5',
       i686: '7c069522a0df8a2c33a12a17f516d7832dbae382ad20107ef28804f9f9a6c848',
     x86_64: '745f7a8b60b4a0705d7d92f24872a949dff5e25de1608030f0a5aeb7c0c54e73'
  })

  depends_on 'imake' => :build
  depends_on 'jbigkit' => :build
  depends_on 'libdeflate'
  depends_on 'libjpeg_turbo'
  depends_on 'libwebp'
  depends_on 'libx11'

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-chunky-strip-read \
      --enable-cxx \
      --enable-defer-strile-load \
      --enable-jpeg \
      --enable-libdeflate \
      --enable-lzma \
      --enable-mdi \
      --enable-pixarlog \
      --enable-webp \
      --enable-zlib \
      --enable-zstd \
      --with-x"

    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
