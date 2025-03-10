require 'buildsystems/meson'

class Gtk_vnc < Meson
  description 'VNC viewer widget for GTK'
  homepage 'https://wiki.gnome.org/Projects/gtk-vnc'
  version '1.3.1'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gtk-vnc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40f49371a8483626e1c080435e4bf7afaf3f9908e6722558d394f65dff9e7874',
     armv7l: '40f49371a8483626e1c080435e4bf7afaf3f9908e6722558d394f65dff9e7874',
     x86_64: 'd135ac0a8ab47f12e4104eabbd36036c3519c1e38722a6e4aae25c0b35a5aac7'
  })

  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'gtk3'
  depends_on 'libgcrypt'
  depends_on 'pulseaudio'
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'harfbuzz' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libx11' # R
  depends_on 'zlib' # R
  depends_on 'gcc_lib' # R

  gnome
end
