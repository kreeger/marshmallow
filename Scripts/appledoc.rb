#!/usr/bin/env ruby

pwd = File.dirname File.dirname(__FILE__)

appledoc = `which appledoc`.strip
name = 'Marshmallow'
company = 'Ben Kreeger'
company_id = 'gr.kree'
output = '~/help'
format = 'xcode'
ignores = %w(Pods)

puts "Updating appledoc documentation."

cmd = "#{appledoc} --project-name #{name} --project-company \"#{company}\" --company-id #{company_id} --output #{output} --logformat #{format} --ignore #{ignores.join(' ')} --exit-threshold 2 ."
puts cmd
system cmd
