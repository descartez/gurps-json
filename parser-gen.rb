# PSUEDO CODE
# 1. grab file
# 2. create new directory to hold said file
# 3. convert grabbed file to JSON
  # a. save in new directory

# Problems:
# - json as is is not valid
# - file needs standardization (downcase all keys and values)?
# - Turns out some also are attributes. What should we do with these?

# Should it just save it all into one big file?

require 'fileutils'
require 'jsonlint'
require 'json'
require 'crack'

basic_set_xml = File.open("gcs-library/Advantages/BasicSet.adq")

basic_adv_hash = Crack::XML.parse(basic_set_xml)

# File.open("gcs-json/advantages/basic_set.json", "w") {|file| file.write(basic_adv_json)}

# basic_set = File.read("gcs-json/advantages/basic_set.json")

# basic_set_hash = JSON.parse(basic_set)

def hash_parser(hash, target_hash)
  hash["advantage_list"]["advantage"].each do |adv|
    p adv["name"].downcase!
    adv["type"].downcase!
    if adv["modifiers"].is_a?(Array)
      if adv["modifiers"].empty? == true
        adv["modifiers"].each do |mod|
          mod["name"].downcase!
        end
      end
    end
    if adv["categories"]["category"].is_a?(String)
      if adv["categories"]["category"].downcase! == "disadvantage"
        p "disadvantage"
        target_hash["disadvantages"] << adv
      elsif adv["categories"]["category"].downcase! == "advantage"
        p "advantage"
        target_hash["advantages"] << adv
      end
    elsif adv["categories"]["category"].is_a?(Array)
      if adv["categories"]["category"].include?("Disadvantage")
        p "disadvantage"
        adv["categories"]["category"].each { |e| p e.downcase! }
        target_hash["disadvantages"] << adv
      elsif adv["categories"]["category"].include?("Advantage")
        p "advantage"
        adv["categories"]["category"].each { |e| p e.downcase! }
        target_hash["advantages"] << adv
      end
    end
  end
end

def advantage_string?(obj, target_hash)

end

def advantage_array?(obj, target_hash)

end

basic_set = {"advantages"=>[], "disadvantages"=>[]};

puts "-"*45
puts "Advantages/Disadvantages"
puts "-"*45

hash_parser(basic_adv_hash, basic_set)
