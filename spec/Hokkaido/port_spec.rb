require 'spec_helper'

describe Hokkaido::Port do
  before do
    File.directory?("chronic").should be_true
    FileUtils.cp_r "chronic", "chronic-spec"
    @info = ["chronic-spec", "chronic.rb", "chronic-spec/lib"]
  end
  
  it "should pass self test" do
    port = Hokkaido::Port.new(@info)
    port.modify
    port.test.should be_true
  end

  after do
    FileUtils.rmtree 'chronic-spec'
  end
end