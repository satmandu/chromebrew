require 'package'

class Bazel_on_arm < Package
  description 'a fast, scalable, multi-language and extensible build system'
  homepage 'https://bazel.build/'
  version '4.2.2-e2b3574'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l'
  source_url 'https://github.com/koenvervloesem/bazel-on-arm.git'
  git_hashtag 'e2b357461c1ab8ea114f45e3f419aa2d98beb0c3'

  depends_on 'openjdk11'

  conflicts_ok # conflicts with bazelisk and bazel

  def self.patch
    system "sed -i 's/wget/curl -OLf/g' scripts/build_bazel.sh"
  end

  def self.build
    system './scripts/build_bazel.sh 4.2.2'
  end

  def self.install
    FileUtils.install 'bazel/output/bazel', "#{CREW_DEST_PREFIX}/bin/bazel", mode: 0o755
  end
end
