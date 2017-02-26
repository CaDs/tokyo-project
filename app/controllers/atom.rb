# frozen_string_literal: true
TokyoProject::App.controllers :atom do
  get :index, provides: [:atom] do
    @pictures = Picture.published.last(20)
    render 'atom/index'
  end
end
