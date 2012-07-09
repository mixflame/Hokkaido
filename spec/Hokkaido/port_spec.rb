require 'spec_helper'

describe Hokkaido::Port do
  before do
    File.directory?("gherkin").should be_true
    FileUtils.cp_r "gherkin", "gherkin-spec"
    @info = ["gherkin-spec", "gherkin.rb", "gherkin-spec/lib"]
  end
  
  it "should pass self test" do
    port = Hokkaido::Port.new(@info)
    port.modify
    port.test.should be_true
  end

  after do
    FileUtils.rmtree 'gherkin-spec'
  end
end