# Hokkaido

Hokkaido attempts to do as much of the work of porting a Gem to RubyMotion for you as possible

Currently, it only supports one patching operation.

* Refold `Requires` into RubyMotion Project Manifest automatically!
* Refold Autoload (same as require)
* Generate and add manifest with proper load order to front of file
* Adds an eval hack to make evaling blocks work in the scope of the binding (no strings)
* FIXME's around binding and calls to eval()

Supported meta-programming techniques left alone, intact and working (instance_eval, define_method, etc).

Includes disabled code to instantly change eval with string to eval with block. Enable if you need it.

e.g.

eval("puts 'hi'")

to

eval do
  puts 'hi'
end

## Usage

Porting: `[bundle exec] Hokkaido port <gem_name> <init_file> <lib_folder>`
Testing: `[bundle exec] Hokkaido test <gem_name> <init_file> <lib_folder>`

Note, `init_file` is looked for within `lib_folder`

## Example

Hokkaido port gherkin gherkin.rb gherkin-test/lib
Hokkaido port term ansicolor.rb term/lib
Hokkaido port cucumber cucumber.rb cucumber/lib
Hokkaido port gherkin gherkin.rb gherkin/lib

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
