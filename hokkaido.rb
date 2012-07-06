#!/usr/bin/env ruby
require 'fileutils'
require 'tempfile'
require 'rubygems'
require 'bundler'
Bundler.require

if ARGV.length == 0
  puts "Hokkaido Tool"
  puts "turn ordinary gems into RubyMotion gems"
  puts "processes: require remover, eval define injecter"
  puts "usage: hokkaido cucumber/"
  exit
end

# edit original gem... tho we backup for safety reasons and testing
@gem_folder = File.join(File.dirname(__FILE__), ARGV[0])
@gem_name = File.basename(@gem_folder)
@backup_folder = File.join(File.dirname(__FILE__), "#{@gem_name}-old")
# DUPE
FileUtils.cp_r(@gem_folder, @backup_folder)


@lib_folder = File.join([@gem_folder, "lib"])
@init_lib = File.join([@lib_folder, "#{@gem_name}.rb"])


@require_libs = []


def parse_gem(init_lib)
  puts "Processing: #{init_lib}"
  @init_file = File.read(init_lib)
  t_file = Tempfile.new("#{File.basename(init_lib)}.bak")
  puts "Tempfile: #{t_file.to_s}"

  @init_file.each_line do |line|
      if line =~ /^require/

        parser = RubyParser.new
        sexp = parser.parse(line)
        library = sexp[3][1][1]


        if library.match(@gem_name)
          # fold in
          @require_libs << library
          full_rb_path = File.join([@lib_folder, "#{library}.rb"])
          parse_gem(full_rb_path)
        end

        # comment it out
        t_file.puts "# #{line}"

      else

        # dont intefere
        t_file.puts line

      end

  end

  # replace file
  FileUtils.mv(t_file.path, init_lib)

  #p require_libs

end

parse_gem(@init_lib)
