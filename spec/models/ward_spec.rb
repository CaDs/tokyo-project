require 'spec_helper'

describe "Ward Model" do
  let(:ward) { Ward.new }
  it 'can be created' do
    ward.should_not be_nil
  end
end
