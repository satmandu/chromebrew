require 'package'

class Ocaml < Package
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'https://ocaml.org/'
  version '4.14.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://caml.inria.fr/pub/distrib/ocaml-4.14/ocaml-4.14.1.tar.xz'
  source_sha256 'c127974d0242576cf47061b20aa9c86d17be0d6aa9687f6ec9835de67be7bb6f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52d09ef49d2c1c36369bfec101bdd3b71abc8d79bc1faff2c892b31fbd741dd5',
     armv7l: '52d09ef49d2c1c36369bfec101bdd3b71abc8d79bc1faff2c892b31fbd741dd5',
       i686: 'cd90b84df17a84c5c879d323741ddfb686ecc3f2f711adf08c6c5647cc92b25f',
     x86_64: '62ddd09a8bf0b4cea07e92d30dad05c706121f133c56e9e46361f754153524d1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure -prefix #{CREW_PREFIX} \
      -libdir #{CREW_LIB_PREFIX}"
    system 'make -j1 world.opt'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
