require 'spec_helper'

describe Hokkaido::GemModifier do
  it "sets up the 3 required input variables" do
    info = ["abc", "cde", "efg"]
    modifier = Hokkaido::GemModifier.new(info)
    modifier.gem_name.should == "abc"
    modifier.init_lib.should == "cde"
    modifier.lib_folder.should == "efg"
  end

end