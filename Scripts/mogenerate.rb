#!/usr/bin/env ruby

model_version = 8
pwd = File.dirname File.dirname(__FILE__)
model_path = File.join pwd, 'Classes', 'Data'
data_model = File.join model_path, 'IFBKModel.xcdatamodeld', "IFBKModel.xcdatamodel"
machine = File.join model_path, 'Machine'
human = model_path
mogen_path = `which mogenerator`.strip

puts "Mogenerating..."

cmd = "#{mogen_path} --model #{data_model} --machine-dir #{machine} --human-dir #{human} --base-class IFBKModel --template-var arc=true"
puts cmd
system cmd
