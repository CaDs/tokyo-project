# frozen_string_literal: true

TokyoProject::App.controllers :rss do
  get :index, provides: [:rss] do
    @cached_pictures = cache_object('rss_pictures', expires: (Padrino.env.to_s == 'production' ? 86_400 : 60)) do
      Picture.published.preload(:vision).last(20)
    end

    @cached_posts = cache_object('rss_posts', expires: (Padrino.env.to_s == 'production' ? 86_400 : 60)) do
      Post.where(is_published: true)
    end
    render 'rss/index'
  end
end
