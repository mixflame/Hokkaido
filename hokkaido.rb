#!/usr/bin/env ruby
require 'fileutils'
require 'tempfile'
require 'rubygems'
require 'bundler'
Bundler.require

# Hokkaido

RUBYMOTION_GEM_CONFIG = <<-HEREDOC
Motion::Project::App.setup do |app|
MAIN_CONFIG_FILES
end
HEREDOC

INCLUDE_STRING = "app.files << File.expand_path(File.dirname(__FILE__) + 'RELATIVE_LIBRARY_PATH')"


if ARGV.length == 0
  puts "Hokkaido"
  puts "turn ordinary gems into RubyMotion gems"
  puts "processes: require remover, eval define injecter"
  puts "usage: hokkaido cucumber/lib/cucumber.rb"
  exit
end

@init_lib = ARGV[0]
@gem_name = @init_lib.split("/")[0]
@lib_folder = File.dirname(@init_lib)

@require_libs = []


def parse_gem(init_lib)
  #puts "Processing: #{init_lib}"
  init_file = File.read(init_lib)
  @t_file = Tempfile.new(File.basename(init_lib))
  # puts "Tempfile: #{@t_file.path}"

  init_file.each_line do |line|
    if line.strip =~ /^require/

      parser = RubyParser.new
      sexp = parser.parse(line)

      library = sexp[3][1][1]


      begin
        if library.match(@gem_name)
          # fold in
          @require_libs << INCLUDE_STRING.gsub("RELATIVE_LIBRARY_PATH", "#{library}.rb")
          full_rb_path = File.join([@lib_folder, "/#{library}.rb"])
          parse_gem(full_rb_path)
        end
      rescue
        # not require "thing"
        @t_file.puts "# FIXME: #require is not supported in RubyMotion"
        @t_file.puts line
        next
      end

      # comment it out
      @t_file.puts "# #{line}"

      next
    end

    # dont intefere
    @t_file.puts line

  end

  # replace file
  FileUtils.mv(t_file.path, init_lib)
  # puts @t_file.size

  # @t_file.each_line do |l|
  #   puts l
  # end

  #p require_libs

end

parse_gem(@init_lib)

def write_manifest

  # creates config manifest
  @manifest = RUBYMOTION_GEM_CONFIG.gsub("MAIN_CONFIG_FILES", @require_libs.uniq.join("\n"))

  File.open(@init_lib, 'a') {|f| f.puts(@manifest) }

end

write_manifest
