require 'ruby_parser'
require 'fileutils'
require 'tempfile'

module Hokkaido
  class GemModifier
    attr_reader :gem_name, :init_lib, :lib_folder

    def initialize(info)
      @gem_name, @init_lib, @lib_folder = info
      #@require_libs_hash = {}
      @require_libs = []
    end

    def manifest!
      parse_gem(@init_lib)
      write_manifest
    end

    def parse_gem(init_lib)
      puts "Processing: #{init_lib}"
      # don't ask
      init_path = init_lib

      #@require_libs_hash[init_path] = []
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

          if require_type == :str && library.match(@gem_name)
            # fold in
            unless @require_libs.include?(library)
              @require_libs.insert 0, INCLUDE_STRING.gsub("RELATIVE_LIBRARY_PATH", "#{library}")
              #@require_libs_hash[init_path] << library #appfiles
              full_rb_path = File.join([@lib_folder, "#{library}.rb"])
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

      #correct_load_order_array = @require_libs_hash.map { |i| i.reverse.flatten }.flatten
      # correct_load_order_array = []

      # i was only used to make sure files werent required twice
      #@require_libs = []

      # correct_load_order_array.each do |lib|
      #   # usually gems dont require with .rb
      #   # hash keys will have it because they are a path
      #   # values wont because they are from #require
      #   if !lib.match(/\.rb/)
      #     lib += ".rb"
      #   end
      #   @require_libs << INCLUDE_STRING.gsub("RELATIVE_LIBRARY_PATH", "#{lib}")
      # end

      # creates config manifest
      @manifest = RUBYMOTION_GEM_CONFIG.gsub("MAIN_CONFIG_FILES", @require_libs.uniq.join("\n"))

      File.open(@init_lib, 'a') {|f| f.puts(@manifest) } #unless TEST_MODE

    end
  end
end