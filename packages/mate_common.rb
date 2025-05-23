require 'buildsystems/autotools'

class Mate_common < Autotools
  description 'Common files for development of MATE packages.'
  homepage 'https://mate-desktop.org'
  version '1.27.1'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://pub.mate-desktop.org/releases/#{version.rpartition('.')[0]}/mate-common-#{version}.tar.xz"
  source_sha256 '4f1f91d0d60e3629999e2ff930574882f511a15831e20b52d93ff0bc8922effa'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '368b90c8aaaee44136b49fe764dfd2f348a82c0c97ec7f9d6a2e7b9f58ab764d',
     armv7l: '368b90c8aaaee44136b49fe764dfd2f348a82c0c97ec7f9d6a2e7b9f58ab764d',
     x86_64: '6b2311710ffa148aa1ae51212f3cd107dd0fec6584371e887e1f086e1f3a04ec'
  })

  depends_on 'gtk_doc'
end
