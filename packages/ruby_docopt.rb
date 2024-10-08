require 'buildsystems/ruby'

class Ruby_docopt < RUBY
  description 'Docopt parses command line arguments from nothing more than a usage message.'
  homepage 'http://docopt.org/'
  version "0.6.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  no_compile_needed
end
