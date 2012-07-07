# Hokkaido

Hokkaido attempts to do as much of the work of porting a Gem to RubyMotion for you as possible

Currently, it only supports one patching operation.

* Refold `Requires` into RubyMotion Project Manifest.

## WARNING: Hokkaido is a work in progress and will fail self-test due to incorrect load order. see recursive method parse_gem in gem_modifier.rb

Where impossible or strange, A `FIXME` is produced.

## Installation

Add this line to your application's Gemfile:

    gem 'Hokkaido'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Hokkaido

## Usage

`[bundle exec] Hokkaido <gem_name> <init_file> <lib_folder>`

## Examples

Hokkaido term term/lib/term/ansicolor.rb term/lib
Hokkaido cucumber cucumber/lib/cucumber.rb cucumber/lib
Hokkaido gherkin gherkin/lib/gherkin.rb gherkin/lib

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
