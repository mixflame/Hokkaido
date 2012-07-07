require "Hokkaido/version"
require 'gem_modifier'

module Hokkaido
  RUBYMOTION_GEM_CONFIG = <<-HEREDOC
  Motion::Project::App.setup do |app|
    MAIN_CONFIG_FILES
  end
  HEREDOC

  INCLUDE_STRING = "app.files << File.expand_path(File.join(File.dirname(__FILE__),'RELATIVE_LIBRARY_PATH'))"

  class Port
    def initialize(info)
      @mod_gem = mod_gem = GemModifier.new(info)
      @mod_gem.modify!
    end

    def success?
      mocklib = File.expand_path('lib/motion_mock.rb')
      system("/usr/bin/env ruby -r #{mocklib} #{@mod_gem.init_lib}")
    end
  end
end
