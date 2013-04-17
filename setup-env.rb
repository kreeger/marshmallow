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
puts "Installing listed pods."
system("pod install >> #{logpath} 2>&1")
puts "Installing other dependencies using Homebrew."
system("brew install #{HOMEBREW_INSTALLS.join(' ')} >> #{logpath} 2>&1")
puts "Building documentation."
system("./Scripts/appledoc.rb >> #{logpath} 2>&1")
puts "Copying fonts."
system("./Scripts/copy_fonts.rb >> #{logpath} 2>&1")
puts "Setting up APIKeys.plist."
system("./Scripts/reset_plists.rb >> #{logpath} 2>&1")

puts "\nAll done! Make sure you setup your 37Signals OAuth keys in Resources/APIKeys.plist."
