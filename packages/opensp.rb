require 'package'

class Opensp < Package
  description 'Suite of SGML/XML processing tools'
  homepage 'https://openjade.sourceforge.net/'
  version '1.5.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/openjade/opensp/1.5.2/OpenSP-1.5.2.tar.gz'
  source_sha256 '57f4898498a368918b0d49c826aa434bb5b703d2c3b169beb348016ab25617ce'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '96b7be4dfbf6a31a3b06f6e0675267e595f58cd235f46c4b5726edb55b835360',
     armv7l: '96b7be4dfbf6a31a3b06f6e0675267e595f58cd235f46c4b5726edb55b835360',
       i686: '429919f9c80c972c546ef6a14f9754a50919fad8ed918c65a56bf9e859029039',
     x86_64: '10c0452e3f3ac2f794029c076e69b347c4002a0d7dea0af4beb742b930da58f0'
  })

  def self.build
    system 'filefix'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-doc-build'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
