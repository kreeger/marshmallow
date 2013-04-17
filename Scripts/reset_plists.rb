#!/usr/bin/env ruby
require 'fileutils'

destination = File.join(File.dirname(__FILE__), '../Resources/APIKeys.plist')
source = destination + '.example'

unless File.exists?(destination)
  FileUtils.cp(source, destination)
end
