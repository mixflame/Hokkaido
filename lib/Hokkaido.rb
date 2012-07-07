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
        Hokkaido::Port.test(@mod_gem.init_lib)
      end
    end

    def self.test(init_lib)
      mocklib = File.expand_path('lib/motion_mock.rb')
      retval = system("/usr/bin/env ruby -r #{mocklib} #{init_lib}")
      if retval
        puts "The #require removal was successful.".colorize(:green)
      else
        puts "The #require removal has failed.".colorize(:red)
      end
      return retval
    end
  end
end
