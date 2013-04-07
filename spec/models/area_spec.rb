require 'spec_helper'

describe "Area Model" do
  let(:area) { Area.new }
  it 'can be created' do
    area.should_not be_nil
  end
end
