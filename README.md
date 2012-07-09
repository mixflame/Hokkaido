# Hokkaido

Hokkaido attempts to do as much of the work of porting a Gem to RubyMotion for you as possible

Currently, it only supports one patching operation.

* Refold `Requires` into RubyMotion Project Manifest automatically!

Now working. New load order math!

for example, in gherkin/lib/gherkin.rb:

# require 'gherkin/lexer/i18n_lexer'
# require 'gherkin/parser/parser'
Motion::Project::App.setup do |app|
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/native/null.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/native.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/formatter/hashable.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/formatter/model.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/rubify.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/formatter/ansi_escapes.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/formatter/step_printer.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/formatter/argument.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/formatter/escaping.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/formatter/pretty_formatter.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/c_lexer.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/rb_lexer.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/js_lexer.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/i18n.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/lexer/i18n_lexer.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/listener/formatter_listener.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin/parser/parser.rb'))
    app.files << File.expand_path(File.join(File.dirname(__FILE__),'gherkin.rb'))
end

Where impossible or strange, A `FIXME` is produced. (not desirable but useful)

The above may be expanded later.

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

Hokkaido term ansicolor.rb term/lib
Hokkaido cucumber cucumber.rb cucumber/lib
Hokkaido gherkin gherkin.rb gherkin/lib

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
