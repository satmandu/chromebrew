require 'fileutils'
require 'json'
require_relative 'const'
require_relative 'crewlog'

def load_json(json_object)
CREW_CONFIG_PATH      = File.join('/usr/local', 'etc/crew')

  # load_json(): (re)load device.json
  json_path = File.join(CREW_CONFIG_PATH, 'device.json')
  json_object = JSON.load_file(json_path, symbolize_names: true)

  # symbolize also values
  json_object.transform_values! {|val| val.is_a?(String) ? val.to_sym : val }
  # puts json_object.inspect
end

@device = load_json(@device)
# puts @device.inspect
puts JSON[@device[:installed_packages]]
