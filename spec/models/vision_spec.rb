require 'spec_helper'

describe "Vision Model" do
  let(:vision) { Vision.new }
  it 'can be created' do
    vision.should_not be_nil
  end
end
