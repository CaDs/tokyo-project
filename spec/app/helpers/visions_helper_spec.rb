require 'spec_helper'

RSpec.describe 'TokyoProjectng::App::VisionsHelper' do
  pending "add some examples to (or delete) #{__FILE__}" do
    let(:helpers) { Class.new }
    before { helpers.extend TokyoProjectng::App::VisionsHelper }
    subject { helpers }

    it 'should return nil' do
      expect(subject.foo).to be_nil
    end
  end
end
