require_relative '../lib/const'
require_relative '../lib/misc_functions'
require_relative '../lib/package_utils'

class Command
  def self.files(pkg)
    # Check if the package is even installed first, as this is the most likely reason we cannot find a filelist.
    unless PackageUtils.installed?(pkg.name)
      puts "Package #{pkg.name} is not installed.".lightred
      return
    end

    # Fake packages do not have any files.
    if pkg.is_fake?
      puts "Package #{pkg.name} is fake and has no files.".lightred
      return
    end

    # We can't do anything if we don't have the filelist.
    unless File.file?(filelist_path = File.join(CREW_META_PATH, "#{pkg.name}.filelist"))
      puts "Package #{pkg.name} does not have a filelist :(".lightred
      return
    end

    # Print the name and description of the package.
    puts pkg.name.lightgreen + ": #{pkg.description}".lightblue

    # Read the file into memory as an array of lines.
    filelist = File.readlines(filelist_path, chomp: true)
    size = 0

    filelist.each do |filename|
      # Skip calculating the filesize if the file doesn't exist.
      next unless File.file?(filename)
      # Ignore symlinks to prevent duplicating calculation.
      next if File.symlink?(filename)
      # Add the size of the file to the total size.
      size += File.size(filename)
    end

    # Print the filelist, the total number of files, and the total size of those files.
    puts filelist
    puts "\nTotal found: #{filelist.count}".lightgreen
    puts "Disk usage: #{MiscFunctions.human_size(size)}".lightgreen
  end
end
