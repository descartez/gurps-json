# PSUEDO CODE
# 1. grab file
# 2. create new directory to hold said file
# 3. convert grabbed file to JSON
  # a. save in new directory

# Problems:
# - json as is is not valid
# - file needs standardization (downcase all keys and values)

# Should it just save it all into one big file?

require 'fileutils'
require 'jsonlint'
require 'json'
require 'crack'

basic_set_xml = File.open("gcs-library/Advantages/BasicSet.adq")

basic_adv_hash = Crack::XML.parse(basic_set_xml)
action_adv_hash = Crack::XML.parse(action_set_xml)

# File.open("gcs-json/advantages/basic_set.json", "w") {|file| file.write(basic_adv_json)}
# File.open("gcs-json/advantages/action_set.json", "w") {|file| file.write(action_adv_json)}

# basic_set = File.read("gcs-json/advantages/basic_set.json")

# basic_set_hash = JSON.parse(basic_set)


puts "-"*45
puts "Advantages/Disadvantages"
puts "-"*45

basic_adv_hash["advantage_list"]["advantage"].each do |adv|
  p adv["name"]
end

# basic_set["advantage_list"]["advantages"].each do |advantage_json|
#   puts advantage_json
#   puts "\n\n"
# end
