require 'package'
require 'convenience_functions'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.79.123'
  license 'MPL-2'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/brave/brave-browser/releases/download/v#{version}/brave-browser-#{version}-linux-amd64.zip"
  source_sha256 '59e4a73387426b7d8b86332577a33ecd277fc7874581bab22e5afd7addebe279'

  no_compile_needed
  no_shrink

  depends_on 'gtk3'
  depends_on 'libcom_err'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.ln_s "#{CREW_PREFIX}/share/brave/brave", "#{CREW_DEST_PREFIX}/bin/brave"
    FileUtils.ln_s CREW_LIB_PREFIX, "#{CREW_DEST_PREFIX}/share/#{ARCH_LIB}"
  end

  def self.postinstall
    ConvenienceFunctions.set_default_browser('Brave', 'brave')
  end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('Brave', 'brave')
  end
end
