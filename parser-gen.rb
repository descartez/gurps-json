# PSUEDO CODE
# 1. grab file
# 2. create new directory to hold said file
# 3. convert grabbed file to JSON
  # a. save in new directory

# Should it just save it all into one big file?

require 'fileutils'
require 'json'
require 'crack'

# start of Advantages
basic_set_xml = File.open("gcs-library/Advantages/BasicSet.adq")
action_set_xml = File.open("gcs-library/Advantages/Action.adq")

basic_adv_json = Crack::XML.parse(basic_set_xml)
action_adv_json = Crack::XML.parse(action_set_xml)

File.open("gcs-json/advantages/basic_set.json", "w") {|file| file.write(basic_adv_json)}
File.open("gcs-json/advantages/action_set.json", "w") {|file| file.write(action_adv_json)}

basic_set = File.read("gcs-json/advantages/basic_set.json")

basic_set_hash = JSON.parse(basic_set)

basic_set_hash["advantage_list"]["advantage_container"].each do |advantage_json|
  puts advantage_json
  puts "\n\n"
end
