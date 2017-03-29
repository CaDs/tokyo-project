# frozen_string_literal: true
TokyoProject::App.controllers :atom do
  get :index, provides: [:atom] do
    @pictures = cache_object('rss_pictures', expires: (Padrino.env.to_s == 'production' ? 86_400 : 60)) do
      Picture.published.preload(:vision).last(20)
    end
    render 'atom/index'
  end
end
