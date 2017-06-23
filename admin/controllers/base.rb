# frozen_string_literal: true

TokyoProject::Admin.controllers :base do
  get :index, map: '/' do
    render 'base/index'
  end
end
