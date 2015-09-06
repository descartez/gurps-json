# PSUEDO CODE
# 1. grab file
# 2. create new directory to hold said file
# 3. convert grabbed file to JSON
  # a. save in new directory

require 'fileutils'
require 'crack'

# start of Advantages
p adv_basic_set = File.open("gcs-library/Advantages/BasicSet.adq")
p adv_action_set = File.open("gcs-library/Advantages/Action.adq")


p basic_adv_set = Crack::XML.parse(adv_action_set)
