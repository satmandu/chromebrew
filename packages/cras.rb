require 'buildsystems/bazel'

class Cras < BAZEL
  description 'ChromeOS Audio Server'
  homepage 'https://www.chromium.org/chromium-os/chromiumos-design-docs/cras-chromeos-audio-server'
  # Version from .bazelversion
  version '6.5.0-66d3579'
  license 'BSD-Google'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://chromium.googlesource.com/chromiumos/third_party/adhd.git'
  git_hashtag '66d3579bdc57487215f854251416226153287b52'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '586a93c5359b39c91a576904a212dde5926581d603263874d71feef6ef6cf1e2',
     armv7l: '586a93c5359b39c91a576904a212dde5926581d603263874d71feef6ef6cf1e2',
     x86_64: '1f53ed96948e29f71d42f1b437e7e4637f6e08a4e573966ec139bb3437ed0d21'
  })

  depends_on 'alsa_lib' # R
  depends_on 'bazel' => :build if ARCH == 'x86_64'
  depends_on 'bazel_on_arm' => :build if %w[aarch64 armv7l].include?(ARCH)
  depends_on 'dbus' # R
  depends_on 'eudev' # R
  depends_on 'gtest' => :build
  depends_on 'iniparser' # R
  depends_on 'ladspa'
  depends_on 'llvm19_dev' => :build
  depends_on 'rust' => :build
  depends_on 'sbc' # R
  depends_on 'speexdsp' # R

  pre_bazel_options 'CC=clang CXX=clang++'
  bazel_build_targets %w[//cras:libcras.pc //cras/src/libcras:cras //cras/src/alsa_plugin:asound_module_ctl_cras //cras/src/alsa_plugin:asound_module_ctl_cras_library //cras/src/alsa_plugin:asound_module_pcm_cras //cras/src/alsa_plugin:asound_module_pcm_cras_library]

  bazel_build_extras do
    Dir.chdir('cras') do
      system 'cat << _EOF_ > 10-cras.conf
pcm.cras {
    type cras
    hint {
        show on
        description "Chromium OS Audio Server"
    }
}
ctl.cras {
    type cras
}
# Default: route all audio through the CRAS plugin.
pcm.!default {
    type cras
    hint {
        show on
        description "Default ALSA Output (currently Chromium OS Audio Server)"
    }
}
ctl.!default {
    type cras
}
_EOF_'
    end
    # system './git_prepare.sh'
    # if ARCH == 'i686'
    # system "CFLAGS='-fuse-ld=lld -msse2' ./configure #{CREW_CONFIGURE_OPTIONS} \
    #--disable-alsa-plugin \
    #--disable-webrtc-apm \
    #--enable-sse42 \
    #--enable-avx \
    #--enable-avx2
    #--enable-fma"
    # else
    # system "CFLAGS='-fuse-ld=lld' ./configure #{CREW_CONFIGURE_OPTIONS} \
    #--disable-alsa-plugin \
    #--disable-webrtc-apm \
    #--enable-sse42 \
    #--enable-avx \
    #--enable-avx2 \
    #--enable-fma"
    # end
    # system 'make'
    # end
  end

  bazel_install_extras do
    Dir.chdir('cras') do
      FileUtils.install '10-cras.conf', "#{CREW_DEST_PREFIX}/share/alsa/alsa.conf.d/"
    end
  end
end
