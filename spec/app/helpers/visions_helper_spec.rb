# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'TokyoProject::App::VisionsHelper' do
  pending "add some examples to (or delete) #{__FILE__}" do
    let(:helpers) { Class.new }
    before { helpers.extend TokyoProject::App::VisionsHelper }
    subject { helpers }

    it 'should return nil' do
      expect(subject.foo).to be_nil
    end
  end
end
