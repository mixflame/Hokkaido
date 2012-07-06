require 'spec_helper'

describe Hokkaido::Modifier do
  it "sets up the 3 required input variables" do
    info = ["abc", "cde", "efg"]
    modifier = Hokkaido::Modifier.new(info)
    modifier.gem_name == "abc"
    modifier.init_lib == "cde"
    modifier.lib_folder == "efg"
  end

end