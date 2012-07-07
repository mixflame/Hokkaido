require "Hokkaido/version"
require 'commander/import'
require 'gem_modifier'
require 'term/ansicolor'
require 'pry'

module Hokkaido
  RUBYMOTION_GEM_CONFIG = "\nMotion::Project::App.setup do |app|\nMAIN_CONFIG_FILES\nend"
  INCLUDE_STRING = "app.files << File.expand_path(File.join(File.dirname(__FILE__),'RELATIVE_LIBRARY_PATH'))"

  class Port
    def initialize(info, options)
      @mod_gem = GemModifier.new(info)
      if options.sim
        @mod_gem.simulate!
      else
        @mod_gem.modify!
        puts "Gem modification complete. It will now be tested.".colorize(:yellow)
        if success?
          puts "The #require removal was successful.".colorize(:green)
        else
          puts "The #require removal has failed.".colorize(:red)
        end
      end
    end

    def success?
      mocklib = File.expand_path('lib/motion_mock.rb')
      system("/usr/bin/env ruby -r #{mocklib} #{@mod_gem.init_lib}")
      puts "Hokkaido self test has concluded."
    end
  end
end
