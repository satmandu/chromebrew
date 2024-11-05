require 'package'

class Bazelisk < Package
  description 'A user-friendly launcher for Bazel.'
  homepage 'https://github.com/bazelbuild/bazelisk'
  version '1.22.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bazelbuild/bazelisk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '624e090aaa2ca7b07fbdef8a5ccf9ca1f29002eff24d97fcb32edb8be3f609ba',
     armv7l: '624e090aaa2ca7b07fbdef8a5ccf9ca1f29002eff24d97fcb32edb8be3f609ba',
       i686: '63ec1e6e04b76329b5e4b1ab7f57d61d21b5be3f2a3ad0e92bed7816a44c2398',
     x86_64: '85461af66dcd350798dafd1b019818576e8173a1b37866940b94c95c3cebfe00'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  conflicts_ok # conflicts with bazel

  def self.build
    system 'go build -o bin/bazelisk'
  end

  def self.install
    FileUtils.install 'bin/bazelisk', "#{CREW_DEST_PREFIX}/bin/bazelisk", mode: 0o755
    FileUtils.install 'bin/bazelisk', "#{CREW_DEST_PREFIX}/bin/bazel", mode: 0o755
  end
end
