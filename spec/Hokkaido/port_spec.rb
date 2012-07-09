require 'spec_helper'



describe Hokkaido::Port do
  it "is a factory" do
    Hokkaido::Port.should respond_to(:new)
  end

  it "should attempt to port a gem to RubyMotion" do
    port = Hokkaido::Port.new(["gherkin", "gherkin.rb", "gherkin/lib"])
    port.success?.should be_true
  end
end