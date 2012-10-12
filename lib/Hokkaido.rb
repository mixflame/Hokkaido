require "Hokkaido/version"
require 'gem_modifier'
#require 'term/ansicolor'

module Hokkaido

RUBYMOTION_GEM_CONFIG = <<-HEREDOC
Motion::Project::App.setup do |app|
MAIN_CONFIG_FILES
end
HEREDOC

EVAL_HACK = <<-HEREDOC
def eval(&block)
  if self.is_a?(Class)
    class_eval(&block)
  elsif self.is_a?(Module)
    module_eval(&block)
  elsif self.is_a?(Object)
    instance_eval(&block)
  end
end
HEREDOC

  INCLUDE_STRING = "  app.files << File.expand_path(File.join(File.dirname(__FILE__),'RELATIVE_LIBRARY_PATH'))"

  class Port

    def initialize(info, options=nil)
      @mod_gem = GemModifier.new(info)
      @true_path = File.join(@mod_gem.lib_folder, @mod_gem.init_lib)
    end

    def modify
      @mod_gem.modify!
    end

    def test
      mocklib = File.expand_path('lib/motion_mock.rb')
      system("/usr/bin/env ruby -r #{mocklib} #{@true_path}")
    end

    def produced_eval_fixme
      File.read(@true_path).include?("FIXME: ")
    end
  end

  def self.self_test_result(port)
    if port.test
      puts "The #require removal was successful." #.colorize(:green)
    else
      puts "The #require removal has failed." #.colorize(:red)
    end
  end

  def self.valid_input?(args)
    if args.length == 3 && args[0].length > 0
      name, init_filename, lib_dir = args
      init_path = File.join(lib_dir, init_filename)
      File.directory?(lib_dir) && File.exists?(init_path)
    end
  end
end
