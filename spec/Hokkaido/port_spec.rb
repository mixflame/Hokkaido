require 'spec_helper'

describe Hokkaido::Port do

  
  it "should pass self test" do
    File.directory?("chronic").should be_true
    FileUtils.cp_r "chronic", "chronic-spec"
    @info = ["chronic-spec", "chronic.rb", "chronic-spec/lib"]
    port = Hokkaido::Port.new(@info)
    port.modify
    port.test.should be_true
    FileUtils.rmtree 'chronic-spec'
  end

  it "should produce a FIXME when eval is used" do
    File.directory?("ansiterm-color").should be_true
    FileUtils.cp_r "ansiterm-color", "ansiterm-spec"
    @info = ["ansiterm-spec", "ansicolor.rb", "ansiterm-spec/lib/term"]
    port = Hokkaido::Port.new(@info)
    port.modify
    port.produced_eval_fixme.should be_true
    FileUtils.rmtree 'ansiterm-spec'
  end


end