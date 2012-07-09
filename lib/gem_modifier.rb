require 'ruby_parser'
require 'fileutils'
require 'tempfile'

# require removal only



module Hokkaido
  class GemModifier
    attr_reader :gem_name, :init_lib, :lib_folder

    def initialize(info)
      @gem_name, @init_lib, @lib_folder = info
      @require_libs = [File.join(@lib_folder, @init_lib)]
    end

    def modify!
      parse_gem(File.join(@lib_folder, @init_lib))
      write_manifest
    end

    # def simulate!
    #   puts "simulator not implemented..."
    # end

    def parse_gem(init_lib)
      # puts "Processing: #{init_lib}"
      # don't ask
      init_path = init_lib

      init_file = File.read(init_lib)
      current_file = ""

      init_file.each_line do |line|
        if line.strip =~ /^require/
          parser = RubyParser.new
          sexp = parser.parse(line)
          call = sexp[2]

          unless call == :require
            # WEIRD SHIT IS HAPPENING
            current_file += line
            next
          end

          require_type = sexp[3][1][0]
          library = sexp[3][1][1]
          #p library

          if require_type == :str && library.match(@gem_name)
            # fold in
            full_rb_path = File.join([@lib_folder, "#{library}.rb"])
            unless @require_libs.include?(full_rb_path)
              file_index = @require_libs.index(init_lib)
              insert_index = file_index
              @require_libs.insert insert_index, full_rb_path
              parse_gem(full_rb_path)
            end
          else
            current_file += "# FIXME: #require is not supported in RubyMotion\n"
            current_file += "# #{line}"
            next
          end
          # comment it out
          current_file += "# #{line}"
          next
        end

        # dont intefere
        current_file += line
      end

      # replace file
      File.open(init_lib, 'w') {|f| f.write(current_file) } #unless TEST_MODE

    end

    def write_manifest

      #puts @require_libs

      @manifest_files = @require_libs.collect do |lib|

        lib = lib.gsub("#{@lib_folder}/", "")

        INCLUDE_STRING.gsub("RELATIVE_LIBRARY_PATH", lib)

      end

      # creates config manifest
      @manifest = RUBYMOTION_GEM_CONFIG.gsub("MAIN_CONFIG_FILES", @manifest_files.join("\n"))

      # puts @manifest

      File.open(File.join(@lib_folder, @init_lib), 'a') {|f| f.puts(@manifest) } #unless TEST_MODE

    end

  end
end