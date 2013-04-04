#!/usr/bin/env ruby
require 'fileutils'

destination = File.join(File.dirname(__FILE__), '../Resources/Fonts/Avenir Next')
FileUtils.mkdir_p destination
FileUtils.cp('/Library/Fonts/Avenir Next.ttc', destination)
