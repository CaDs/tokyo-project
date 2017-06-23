# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'TokyoProject::App::BlogHelper' do
  pending "add some examples to (or delete) #{__FILE__}" do
    let(:helpers) { Class.new }
    before { helpers.extend TokyoProject::App::BlogHelper }
    subject { helpers }

    it 'should return nil' do
      expect(subject.foo).to be_nil
    end
  end
end
