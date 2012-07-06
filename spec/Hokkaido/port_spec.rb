require 'spec_helper'

describe Hokkaido::Port do
  it "is a factory" do
    Hokkaido::Port.should respond_to(:new)
  end
end