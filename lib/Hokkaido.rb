require "Hokkaido/version"
require 'gem_modifier'
require 'term/ansicolor'
require 'pry'



module Hokkaido

RUBYMOTION_GEM_CONFIG = <<-HEREDOC
Motion::Project::App.setup do |app|
MAIN_CONFIG_FILES
end
HEREDOC

  INCLUDE_STRING = "    app.files << File.expand_path(File.join(File.dirname(__FILE__),'RELATIVE_LIBRARY_PATH'))"

  class Port

    def initialize(info, options=nil)
      @mod_gem = GemModifier.new(info)
      # if options.sim
      #   @mod_gem.simulate!
      # else
        @mod_gem.modify!
        puts "Gem modification complete. It will now be tested.".colorize(:yellow)
        #Hokkaido::Port.test()
      # end
    end

    def test
      true_path = File.join(@mod_gem.lib_folder, @mod_gem.init_lib)
      mocklib = File.expand_path('lib/motion_mock.rb')
      retval = system("/usr/bin/env ruby -r #{mocklib} #{true_path}")
      if retval
        puts "The #require removal was successful.".colorize(:green)
      else
        puts "The #require removal has failed.".colorize(:red)
      end
      return retval
    end
  end

end
