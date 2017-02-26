# frozen_string_literal: true
TokyoProject::App.controllers :rss do
  get :index, provides: [:rss] do
    @cached_pictures = cache('rss_pictures', expires: (Padrino.env.to_s == 'production' ? 86_400 : 5)) do
      @pictures_array = Picture.published.preload(:vision).last(20)
    end

    @cached_posts = cache('rss_posts', expires: (Padrino.env.to_s == 'production' ? 86_400 : 5)) do
      @posts = Post.where(is_published: true)
    end
    render 'rss/index'
  end
end
