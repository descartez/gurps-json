# PSUEDO CODE
# 1. grab file
# 2. create new directory to hold said file
# 3. convert grabbed file to JSON
  # a. save in new directory

# Problems:
# - json as is is not valid
# - file needs standardization (downcase all keys and values)? DONE
# - Turns out some also are attributes. What should we do with these?
# - some objects only have one modifier, which means it is not in an array. Needs to be in array.
  # - Same problem with advantage + attribute || disadvantage + attribute objects.
    # They have one element but they still need to be placed in array

# Should it just save it all into one big file?

require 'fileutils'
require 'json'
require 'crack'

  def hash_parser(hash, target_hash)
    hash["advantage_list"]["advantage"].each do |adv|
      adv["name"].downcase!
      adv["type"].downcase!
      if adv["modifier"].is_a?(Array)
        if adv["modifier"].empty? == false
          adv["modifier"].each do |mod|
            mod["name"].downcase!
          end
        end
      elsif adv["modifier"].is_a?(Array) == false && adv["modifier"].nil? == false
        adv["modifier"]["name"].downcase!
        holding_array = [adv["modifier"]]
        adv["modifier"] = holding_array
      end
      if adv["categories"]["category"].is_a?(String)
        advantage_string?(adv, target_hash)
      elsif adv["categories"]["category"].is_a?(Array)
        advantage_array?(adv, target_hash)
      end
    end
  end

  def advantage_string?(obj, target_hash)
    if obj["categories"]["category"].downcase! == "disadvantage"
      target_hash["disadvantages"] << obj
    elsif obj["categories"]["category"].downcase! == "advantage"
      target_hash["advantages"] << obj
    end
  end

  def advantage_array?(obj, target_hash)
    if obj["categories"]["category"].include?("Disadvantage")
      obj["categories"]["category"].each { |e| e.downcase! }
      target_hash["disadvantages"] << obj
    elsif obj["categories"]["category"].include?("Advantage")
      obj["categories"]["category"].each { |e| e.downcase! }
      target_hash["advantages"] << obj
    end
  end

  def file_writer(path, hash)
    File.open(path, "w") {|file| file.write(JSON.pretty_generate(hash))}
  end

basic_set = {"advantages"=>[], "disadvantages"=>[]};
action_set = {"advantages"=>[], "disadvantages"=>[]}

# puts "-"*45
# puts "Advantages/Disadvantages"
# puts "-"*45
p "running!"
# ---Basic Set---
basic_set_xml = File.open("gcs-library/Advantages/BasicSet.adq")

basic_adv_hash = Crack::XML.parse(basic_set_xml)

hash_parser(basic_adv_hash, basic_set)
file_writer("gcs-json/advantages/basic_set.json",basic_set)

# ---Action Set---
# action_set_xml =  File.open("gcs-library/Advantages/Action.adq")

# action_adv_hash = Crack::XML.parse(action_set_xml)

# hash_parser(action_adv_hash, action_set)
# file_writer("gcs-json/advantages/action_set.json", action_set)

p "done!"
