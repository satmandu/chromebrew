require 'fileutils'
require 'json'
require_relative 'const'
require_relative 'crewlog'

def load_json
  # load_json(): (re)load device.json
  json_path = File.join(CREW_CONFIG_PATH, 'device.json')
  @device   = JSON.load_file(json_path, symbolize_names: true)

  # symbolize also values
  @device.transform_values! {|val| val.is_a?(String) ? val.to_sym : val }
end

def save_json(json_object)
  crewlog 'Saving device.json...'
  begin
    File.write File.join(CREW_CONFIG_PATH, 'device.json.tmp'), JSON.pretty_generate(JSON.parse(json_object.to_json))
  rescue StandardError
    puts 'Error writing updated packages json file!'.lightred
    abort
  end

  # Copy over original if the write to the tmp file succeeds.
  FileUtils.cp("#{CREW_CONFIG_PATH}/device.json.tmp", File.join(CREW_CONFIG_PATH, 'device.json')) && FileUtils.rm("#{CREW_CONFIG_PATH}/device.json.tmp")
  load_json
end
