require 'package'

class Patchutils < Package
  description 'Patchutils is a small collection of programs that operate on patch files.'
  homepage 'http://cyberelk.net/tim/software/patchutils/'
  version '0.3.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'http://cyberelk.net/tim/data/patchutils/stable/patchutils-0.3.4.tar.xz'
  source_sha256 'cf55d4db83ead41188f5b6be16f60f6b76a87d5db1c42f5459d596e81dabe876'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'a016f2bf4f5cd6711295f46e30563dcbd910b714be964b61f00cb68ef97d0f2c',
     armv7l: 'a016f2bf4f5cd6711295f46e30563dcbd910b714be964b61f00cb68ef97d0f2c',
       i686: '3bbc58f6e110e6d7437c0fd7acaf2bd49b7afb51609d577483df3efddbc8e034',
     x86_64: '47995cc77fbf3bf7dbea906fc2bb7ffd28be265fdf64f970e00cfa85edc55ace'
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
