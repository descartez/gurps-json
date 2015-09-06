# PSUEDO CODE
# 1. grab file
# 2. create new directory to hold said file
# 3. convert grabbed file to JSON
  # a. save in new directory

require 'fileutils'
require 'crack'

p f = File.open("gcs-library/Advantages/BasicSet.adq")

p basic_adv_set = Crack::XML.parse(f)
