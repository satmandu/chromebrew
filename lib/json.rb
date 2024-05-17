require 'fileutils'
require 'json'
require_relative 'const'
require_relative 'crewlog'

def load_json(json_object)
  # load_json(): (re)load device.json & symbolize values
  json_path = File.join(CREW_CONFIG_PATH, 'device.json')
  json_object = JSON.load_file(json_path, symbolize_names: true).transform_values! {|val| val.is_a?(String) ? val.to_sym : val }
end

def save_json(json_object)
  json_path = File.join(CREW_CONFIG_PATH, 'device.json')
  tmp_json_path = File.join(CREW_CONFIG_PATH, 'device.json.tmp')
  crewlog "Generating and saving device.json to #{tmp_json_path}..."
  begin
    File.write tmp_json_path, JSON.pretty_generate(JSON.parse(json_object.to_json))
  rescue StandardError
    puts 'Error writing updated packages json file!'.lightred
    abort
  end

  # Copy over original if the write to the tmp file succeeds.
  crewlog "The device.json changes are: diff -Npaur #{json_path} #{tmp_json_path}"
  crewlog `diff -Npaur #{json_path} #{tmp_json_path}`.chomp
  puts `diff -Npaur #{json_path} #{tmp_json_path}`.chomp
  # system "ls -aFl /usr/local/etc/crew/"
  FileUtils.mv(tmp_json_path, json_path) && load_json(json_object)
  # system "ls -aFl /usr/local/etc/crew/"
  # crewlog "Deleting tmp device.json from #{tmp_json_path}..."
  # FileUtils.rm(tmp_json_path)
  # load_json
end
