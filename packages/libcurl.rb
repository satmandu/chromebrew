require 'package'
Package.load_package("#{__dir__}/curl.rb")

class Libcurl < Package
  description Curl.description
  homepage Curl.homepage
  version Curl.version
  license Curl.license
  compatibility Curl.compatibility

  is_fake

  depends_on 'curl'

  def self.postinstall
    system 'crew reinstall curl' unless File.file?("#{CREW_PREFIX}/bin/curl")
  end
end
