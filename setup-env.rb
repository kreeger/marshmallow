#!/usr/bin/env ruby

HOMEBREW_INSTALLS = %w(mogenerator appledoc pngnq)

puts "Welcome to Marshmallow!"
puts "If you haven't already, checkout the readme @ `readme.markdown`."

logpath = "./install.log"
system("touch #{logpath}")
system("echo > #{logpath}")

puts "\nSetting up prerequisites."
puts "Installing bundled gems."
system("bundle install >> #{logpath}")
# puts "Setting up custom CocoaPods repository."
# system("pod repo add custom-cocoapods git://github.com/kreeger/custom-cocoapods.git > #{logpath} 2>&1")
puts "Installing listed pods."
system("pod install >> #{logpath} 2>&1")
puts "Installing other dependencies using Homebrew."
system("brew install #{HOMEBREW_INSTALLS.join(' ')} >> #{logpath} 2>&1")
puts "Building documentation."
system("./Scripts/appledoc.rb >> #{logpath} 2>&1")
puts "Copying fonts."
system("./Scripts/copy_fonts.rb >> #{logpath} 2>&1")

puts "\nAll done!"
