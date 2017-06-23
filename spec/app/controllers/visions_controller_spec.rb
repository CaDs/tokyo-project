# frozen_string_literal: true

require 'spec_helper'

RSpec.describe '/visions' do
  pending "add some examples to #{__FILE__}" do
    before do
      get '/visions'
    end

    it 'returns hello world' do
      expect(last_response.body).to eq 'Hello World'
    end
  end
end
