require 'package'

class Webkitgtk_6 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  version "2.44.2-#{CREW_ICU_VER}"
  license 'LGPL-2+ and BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.37'
  source_url "https://webkitgtk.org/releases/webkitgtk-#{version.split('-').first}.tar.xz"
  source_sha256 '523f42c8ff24832add17631f6eaafe8f9303afe316ef1a7e1844b952a7f7521b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85ed089e4dc72c58ec3630ccfb7cfe2be614c5c4f3a49c367acd1d36ea34e0b1',
     armv7l: '85ed089e4dc72c58ec3630ccfb7cfe2be614c5c4f3a49c367acd1d36ea34e0b1',
     x86_64: '6878f94647d5b3337f1e6ebab2bd2a095ed870cf3bf5e8ebb4c5c67ebace73d0'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo'
  depends_on 'ccache' => :build
  depends_on 'dav1d'
  depends_on 'enchant' # R
  depends_on 'fontconfig'
  depends_on 'freetype' # R
  depends_on 'gcc10' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'hyphen' # R
  depends_on 'icu4c' # R
  depends_on 'lcms' # R
  depends_on 'libavif' # R
  depends_on 'libbacktrace' # R
  depends_on 'libdrm' # R
  depends_on 'libepoxy' # R
  depends_on 'libgcrypt' # R
  depends_on 'libglvnd' # R
  depends_on 'libgpg_error' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libjxl' # R
  depends_on 'libnotify'
  depends_on 'libpng' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
  depends_on 'libtasn1' # R
  depends_on 'libwebp' # R
  depends_on 'libwpe' # R
  depends_on 'libx11' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxdamage' # R
  depends_on 'libxml2' # R
  depends_on 'libxrender' # R
  depends_on 'libxslt' # R
  depends_on 'libxt' # R
  depends_on 'mesa' # R
  depends_on 'openjpeg' # R
  depends_on 'pango' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'sqlite' # R
  depends_on 'unifdef' => :build
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland' # R
  depends_on 'woff2' # R
  depends_on 'wpebackend_fdo' # R
  depends_on 'zlib' # R

  no_env_options

  def self.patch
    system "sed -i 's,/usr/bin,/usr/local/bin,g' Source/JavaScriptCore/inspector/scripts/codegen/preprocess.pl"
    @arch_flags = ''
    @gcc_ver = ''
    if ARCH == 'armv7l' || ARCH == 'aarch64'
      ## Patch from https://bugs.webkit.org/show_bug.cgi?id=226557#c27 to
      ## handle issue with gcc > 11.
      # @gcc_patch = <<~'GCCEOF'
      # diff --git a/Source/cmake/WebKitCompilerFlags.cmake b/Source/cmake/WebKitCompilerFlags.cmake
      # index 77ebb802ebb03450b5e96629a47b6819a68672c6..d49d6e43d7eeb6673c624e00eadf3edfca0674eb 100644
      #--- a/Source/cmake/WebKitCompilerFlags.cmake
      #+++ b/Source/cmake/WebKitCompilerFlags.cmake
      # @@ -143,6 +143,13 @@ if (COMPILER_IS_GCC_OR_CLANG)
      # WEBKIT_PREPEND_GLOBAL_CXX_FLAGS(-Wno-nonnull)
      # endif ()

      # +    # This triggers warnings in wtf/Packed.h, a header that is included in many places. It does not
      # +    # respect ignore warning pragmas and we cannot easily suppress it for all affected files.
      # +    # https://bugs.webkit.org/show_bug.cgi?id=226557
      # +    if (CMAKE_CXX_COMPILER_ID MATCHES "GNU" AND ${CMAKE_CXX_COMPILER_VERSION} VERSION_GREATER_EQUAL "11.0")
      # +        WEBKIT_PREPEND_GLOBAL_CXX_FLAGS(-Wno-stringop-overread)
      # +    endif ()
      # +
      ## -Wexpansion-to-defined produces false positives with GCC but not Clang
      ## https://bugs.webkit.org/show_bug.cgi?id=167643#c13
      # if (CMAKE_CXX_COMPILER_ID MATCHES "GNU")
      # GCCEOF
      # File.write('gcc.patch', @gcc_patch)
      # system 'patch -Np1 -F 10 -i gcc.patch'
      # Patch from https://github.com/WebKit/WebKit/pull/1233
      # downloader 'https://patch-diff.githubusercontent.com/raw/WebKit/WebKit/pull/1233.diff',
      #           '70c990ced72c5551b01c9d7c72da7900d609d0f7891e7b99ab132ac1b4aa33ea'
      # system "sed -i 's,data.pixels->bytes(),data.pixels->data(),' 1233.diff"
      # system 'patch -Np1 -F 10 -i 1233.diff'
      # Patch from https://github.com/WebKit/WebKit/pull/2926
      # downloader 'https://patch-diff.githubusercontent.com/raw/WebKit/WebKit/pull/2926.diff',
      # '26a8d5a9dd9d61865645158681b766e13cf05b3ed07f30bebb79ff73259d0664'
      # system "sed -i '22,63d' 2926.diff"
      # system 'patch -Np1 -F 10 -i 2926.diff'
      # @arch_flags = '-mtune=cortex-a15 -mfloat-abi=hard -mfpu=neon -mtls-dialect=gnu -marm -mlibarch=armv8-a+crc+simd -march=armv8-a+crc+simd'
      @arch_flags = '-mfloat-abi=hard -mtls-dialect=gnu -mthumb -mfpu=vfpv3-d16 -mlibarch=armv7-a+fp -march=armv7-a+fp'
    end
    @gcc_ver = '-10'
    @new_gcc = <<~NEW_GCCEOF
      #!/bin/bash
      gcc#{@gcc_ver} #{@arch_flags} $@
    NEW_GCCEOF
    @new_gpp = <<~NEW_GPPEOF
      #!/bin/bash
      g++#{@gcc_ver} #{@arch_flags} $@
    NEW_GPPEOF
    FileUtils.mkdir_p 'bin'
    File.write('bin/gcc', @new_gcc)
    FileUtils.chmod 0o755, 'bin/gcc'
    File.write('bin/g++', @new_gpp)
    FileUtils.chmod 0o755, 'bin/g++'
  end

  def self.build
    # This builds webkit2gtk5 (which uses gtk4, but not libsoup2)
    @workdir = Dir.pwd
    # Bubblewrap sandbox breaks on epiphany with
    # bwrap: Can't make symlink at /var/run: File exists
    # LDFLAGS from debian: -Wl,--no-keep-memory
    unless File.file?('build.ninja')
      @arch_linker_flags = ARCH == 'x86_64' ? '' : '-Wl,--no-keep-memory'
      system "CREW_LINKER_FLAGS='#{@arch_linker_flags}' CC='#{@workdir}/bin/gcc' CXX='#{@workdir}/bin/g++' \
          cmake -B builddir -G Ninja \
          #{CREW_CMAKE_OPTIONS.sub('-pipe', '-pipe -Wno-error').gsub('-flto=auto', '').sub('-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE', '')} \
          -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
          -DENABLE_BUBBLEWRAP_SANDBOX=OFF \
          -DENABLE_DOCUMENTATION=OFF \
          -DENABLE_JOURNALD_LOG=OFF \
          -DENABLE_GAMEPAD=OFF \
          -DENABLE_MINIBROWSER=ON \
          -DUSE_SYSTEM_MALLOC=ON \
          -DPORT=GTK \
          -DUSE_GTK4=ON \
          -DUSE_JPEGXL=ON \
          -DUSE_SOUP2=OFF \
          -DPYTHON_EXECUTABLE=`which python` \
          -DUSER_AGENT_BRANDING='Chromebrew'"
    end
    @counter = 1
    @counter_max = 20
    loop do
      break if Kernel.system "#{CREW_NINJA} -C builddir -j #{CREW_NPROC}"

      puts "Make iteration #{@counter} of #{@counter_max}...".orange

      @counter += 1
      break if @counter > @counter_max
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/WebKitWebDriver", "#{CREW_DEST_PREFIX}/bin/WebKitWebDriver_6"
  end
end
