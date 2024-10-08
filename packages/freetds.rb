require 'package'

class Freetds < Package
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.2.18'
  license 'GPL-2'
  compatibility 'all'
  source_url "ftp://ftp.freetds.org/pub/freetds/stable/freetds-#{version}.tar.gz"
  source_sha256 'a02c27802da15a3ade85bbaab6197713cd286f036409af9bba2ab4c63bdf57c3'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'a31c467c683a3b574fb59cd45d8511e1a5824d5ea9ab93b3fe4816b42447d041',
     armv7l: 'a31c467c683a3b574fb59cd45d8511e1a5824d5ea9ab93b3fe4816b42447d041',
       i686: '2e908be34fae3b20fdbb9b1b947576a14496f8b48b57c095511f50e12f84240d',
     x86_64: '1ecd9180df531b7c85b28719d9685820f2427e516f26787b51cab750e4ce8bf9'
  })

  depends_on 'unixodbc'

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts "Edit the #{CREW_PREFIX}/etc/freetds.conf file to add servers.".lightblue
    puts
    puts "Test the connection with #{CREW_PREFIX}/bin/tsql.".lightblue
    puts
  end
end
