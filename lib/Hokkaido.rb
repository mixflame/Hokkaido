require "Hokkaido/version"
require 'gem_modifier'
require 'term/ansicolor'

module Hokkaido
  RUBYMOTION_GEM_CONFIG = "\nMotion::Project::App.setup do |app|\nMAIN_CONFIG_FILES\nend"
  INCLUDE_STRING = "app.files << File.expand_path(File.join(File.dirname(__FILE__),'RELATIVE_LIBRARY_PATH'))"

  class Port
    def initialize(info)
      @mod_gem = mod_gem = GemModifier.new(info)
      @mod_gem.modify!
    end

    def success?
      mocklib = File.expand_path('lib/motion_mock.rb')
      system("/usr/bin/env ruby -r #{mocklib} #{@mod_gem.init_lib}")
      puts "Hokkaido self test has concluded."
    end
  end

  def self.input_valid?(args)
    args.length == 3 && File.exists?(args[1]) && 
    File.directory?(args[2]) && args[0].length > 0
  end
end
