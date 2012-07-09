require 'spec_helper'



describe Hokkaido::Port do
  it "is a factory" do
    Hokkaido::Port.should respond_to(:new)
  end

  it "should attempt to port a gem to RubyMotion" do
    port = Hokkaido::Port.new(["gherkin", "gherkin.rb", "gherkin/lib"])
    port.test.should be_true
  end
end