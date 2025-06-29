require 'package'
Package.load_package("#{__dir__}/llvm20_build.rb")

class Llvm20_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm20_build.homepage
  version '20.1.6'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm20_build.version}".orange if version != Llvm20_build.version
  license Llvm20_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fbd5e772e7eb0f9d347a6c599545c1cdb1ccea33e983dbe4ba8fd96783e9eb77',
     armv7l: 'fbd5e772e7eb0f9d347a6c599545c1cdb1ccea33e983dbe4ba8fd96783e9eb77',
       i686: '9e105b344d7cfea40c25c8ffa7c556717d5a4e42ebffe9786fc80f563cc7454a',
     x86_64: '31c92e14d00053c1bee21de49475d0b00e805c1155ff02eaf2d6c009d2747cfa'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm20_build' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm20_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm20_build.filelist')
    abort 'File list for llvm20_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
