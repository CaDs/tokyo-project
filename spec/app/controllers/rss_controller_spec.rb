# frozen_string_literal: true
require 'spec_helper'

RSpec.describe '/rss' do
  pending "add some examples to #{__FILE__}" do
    before do
      get '/rss'
    end

    it 'returns hello world' do
      expect(last_response.body).to eq 'Hello World'
    end
  end
end
