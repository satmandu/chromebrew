require 'package'

class Libheif < Package
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  @_ver = '1.11.0'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://github.com/strukturag/libheif/releases/download/v#{@_ver}/libheif-#{@_ver}.tar.gz"
  source_sha256 'c550938f56ff6dac83702251a143f87cb3a6c71a50d8723955290832d9960913'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.11.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.11.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.11.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.11.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '125dba5b3e33ea262ffbca43f710bda5dd810904c64f6cc2a01b8ce99574529e',
     armv7l: '125dba5b3e33ea262ffbca43f710bda5dd810904c64f6cc2a01b8ce99574529e',
       i686: 'df03e7eec575622aa259bff7560eab13786d94c23eeacfc0a36a0f8e91496b84',
     x86_64: 'a7df0114e719113091d2a73f504041c5a24d50a9c10f46c286afafaed56301f9'
  })

  depends_on 'libde265'
  depends_on 'libjpeg_turbo'
  depends_on 'libpng'
  depends_on 'libx265'
  depends_on 'libaom'
  depends_on 'dav1d'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DWITH_EXAMPLES=NO \
        -W no-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system 'gdk-pixbuf-query-loaders --update-cache'
  end
end
