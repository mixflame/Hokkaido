require "Hokkaido/version"
require 'gem_modifier'

module Hokkaido
  
  class Port
    def initialize(info)
      # remove requires
      #@mod_gem = mod_gem = GemModifier.new(info)
      #@mod_gem.remove_requires!
    end

    def success?
      mocklib = File.expand_path('lib/motion_mock.rb')
      system("/usr/bin/env ruby -r #{mocklib} #{@mod_gem.init_lib}")
    end
  end

end
