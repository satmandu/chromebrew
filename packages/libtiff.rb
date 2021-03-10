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
    aarch64: 'd03ee1b9843ed744ff39e3a1c717ed276061e4601b4fa12175297dfe0ca87483',
     armv7l: 'd03ee1b9843ed744ff39e3a1c717ed276061e4601b4fa12175297dfe0ca87483',
       i686: 'fc862ebebdb6a1edaaa54ff22cbfc59dc9a9e6bbb35747e28acb88a615f5c1c8',
     x86_64: '85c8ef455fdc5d9125079622606a0d2b55ec3523272b08fffb91a080ea379785'
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
