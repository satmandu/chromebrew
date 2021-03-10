require 'package'

class Libjpeg_turbo < Package
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  @_ver = '2.0.90'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/libjpeg-turbo/libjpeg-turbo/archive/#{@_ver}.tar.gz"
  source_sha256 '6a965adb02ad898b2ae48214244618fe342baea79db97157fdc70d8844ac6f09'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg_turbo-2.0.90-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg_turbo-2.0.90-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg_turbo-2.0.90-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg_turbo-2.0.90-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0b37e7892a437e38932a66209835a1c513bd07f48e172d0749d18f16bf6716c4',
     armv7l: '0b37e7892a437e38932a66209835a1c513bd07f48e172d0749d18f16bf6716c4',
       i686: '537a2b0ddd0701af94a0660d2c8273ec78a313989e0851eba51dd152412f8b69',
     x86_64: '1f6c474ef8a6077ecbf7304a6657777b9d55beb935d817cfbd7c49a17239a24b'
  })

  depends_on 'yasm' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DWITH_JPEG8=1 \
        -DWITH_JAVA=OFF \
        -DWITH_12BIT=ON \
        -W no-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.check
    system 'ninja -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
