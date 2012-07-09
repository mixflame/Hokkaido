require "Hokkaido/version"
require 'gem_modifier'

module Hokkaido

RUBYMOTION_GEM_CONFIG = <<-HEREDOC
Motion::Project::App.setup do |app|
MAIN_CONFIG_FILES
end
HEREDOC

INCLUDE_STRING = "    app.files << File.expand_path(File.join(File.dirname(__FILE__),'RELATIVE_LIBRARY_PATH'))"

  class Port
    def initialize(info)
      # remove requires
      @mod_gem = mod_gem = GemModifier.new(info)
      @mod_gem.remove_requires!
    end

    def success?
      true_path = File.join(@mod_gem.lib_folder, @mod_gem.init_lib)
      mocklib = File.expand_path('lib/motion_mock.rb')
      system("/usr/bin/env ruby -r #{mocklib} #{true_path}")
    end
  end

end
