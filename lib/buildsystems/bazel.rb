require 'package'

class BAZEL < Package
  property :bazel_build_extras, :bazel_build_relative_dir, :bazel_build_targets, :bazel_install_extras, :bazel_options, :pre_bazel_options

  def self.build
    @bazel_build_relative_dir ||= ''
    @crew_bazel_options = @no_lto ? CREW_BAZEL_FNO_LTO_OPTIONS : CREW_BAZEL_OPTIONS
    puts 'Additional bazel options being used:'.orange
    method_list = methods.grep(/bazel_/).delete_if { |i| send(i).blank? }
    method_list.each do |method|
      puts "#{method}: #{send method}".orange
    end
    @mold_linker_prefix_cmd = CREW_LINKER == 'mold' ? 'mold -run' : ''
    puts "Bazel targets are:"
    system "bazel query ..."
    @bazel_build_targets.each do |target|
      puts "Bazel target: #{target}"
      system "#{@pre_bazel_options} #{@mold_linker_prefix_cmd} bazel --output_base=#{CREW_DEST_PREFIX} build --package_path %workspace%:/#{@bazel_build_relative_dir} -c opt --jobs=#{CREW_NPROC} #{@crew_bazel_options} #{@bazel_options} #{target}"
    end
    @bazel_build_extras&.call
  end

  def self.install
    @bazel_install_extras&.call
  end

  def self.check
    puts "Testing with #{CREW_NINJA} test.".orange if @run_tests
    system "#{@pre_bazel_options} #{@mold_linker_prefix_cmd} bazel --output_base=#{CREW_DEST_PREFIX} test --package_path %workspace%:/#{@bazel_build_relative_dir} -c opt --jobs=#{CREW_NPROC} --test_summary=detailed #{@crew_bazel_options} #{@bazel_options}" if @run_tests
  end
  
  def self.postinstall
    system 'bazel shutdown'
  end
end
