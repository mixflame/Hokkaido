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

      # build manifest with pokemon tool
      pokemon = Pokemon.new(info)

      # remove requires
      #@mod_gem = mod_gem = GemModifier.new(info)
      #@mod_gem.remove_requires!
    end

    def success?
      mocklib = File.expand_path('lib/motion_mock.rb')
      system("/usr/bin/env ruby -r #{mocklib} #{@mod_gem.init_lib}")
    end
  end

  class Pokemon

    attr_accessor :init_lib, :gem_name, :required_libs

    def require(file)
      p File.join(@lib_folder, file)
      @required_libs << file if file.include?(@gem_name)
      super File.join(@lib_folder, file)
    end

    def initialize(info)
      @required_libs = []
      @gem_name, @init_lib, @lib_folder = info
      require init_lib
    end

  end



end
