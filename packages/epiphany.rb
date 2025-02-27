# Adapted from Arch Linux epiphany PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/epiphany/trunk/PKGBUILD

require 'buildsystems/meson'

class Epiphany < Meson
  description 'A GNOME web browser based on the WebKit rendering engine'
  homepage 'https://wiki.gnome.org/Apps/Web'
  version '43.1'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/epiphany.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'edbfc2a6ef0097b8ffbb55bd8696a996c9ea148281aba325c0d2534425a53d77',
     armv7l: 'edbfc2a6ef0097b8ffbb55bd8696a996c9ea148281aba325c0d2534425a53d77',
     x86_64: '0757192bb0ba72bf09da813e4ddabee332f3ae9ad1b8d621a3f9b23bf8658305'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'docbook_xml' => :build
  depends_on 'freetype' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gcr_3' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gmp' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'help2man' => :build
  depends_on 'iso_codes' => :build
  depends_on 'json_glib' # R
  depends_on 'libarchive' # R
  depends_on 'libdazzle' # R
  depends_on 'libhandy' # R
  depends_on 'libportal' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'lsb_release' => :build
  depends_on 'nettle' # R
  depends_on 'pango' # R
  depends_on 'sqlite' # R
  depends_on 'startup_notification' => :build
  depends_on 'valgrind' => :build
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'gcc_lib' # R

  gnome
end
