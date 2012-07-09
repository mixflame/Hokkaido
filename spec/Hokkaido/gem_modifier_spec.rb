require 'spec_helper'

describe Hokkaido::GemModifier do
  it "sets up the 3 required input variables" do
    info = ["cucumber", "cucumber/lib/cucumber.rb", "cucumber/lib"]
    modifier = Hokkaido::GemModifier.new(info)
    modifier.gem_name.should == "cucumber"
    modifier.init_lib.should == "cucumber/lib/cucumber.rb"
    modifier.lib_folder.should == "cucumber/lib"
  end
end