#!/usr/bin/env ruby
require 'rubygems'
require 'bundler'
Bundler.require

if ARGV.length == 0
  puts "Hokkaido Tool"
  puts "turn ordinary gems into RubyMotion gems"
  puts "processes: require remover, eval define injecter"
  puts "hokkaido <gem_folder>"
  exit
end

gem_folder = File.join(File.dirname(__FILE__), ARGV[0])
puts "Processing: #{gem_folder}"


