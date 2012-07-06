require 'rubygems'
require 'pry'

module Motion
  FILES = []
  module Project
    module App
      class Files
        def self.<<(path)
          Motion::FILES << path
          Kernel.require path
        end
      end
      def self.setup(&block)
        block.call(self)
      end
      def self.files
        Files
      end
    end
  end
end
