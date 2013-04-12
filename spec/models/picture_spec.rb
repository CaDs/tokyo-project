require 'spec_helper'

describe "Picture Model" do
  let(:picture) { Picture.new }
  it 'can be created' do
    picture.should_not be_nil
  end
end
