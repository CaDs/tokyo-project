TokyoProject.controllers :rss do
  get :index, :provides => [:rss] do
    @pictures = cache("rss_pictures", expires_in: (Padrino.env.to_s == "production" ? 3600 : 5)) do
      Picture.published
    end
    @posts = cache("rss_posts", expires_in: (Padrino.env.to_s == "production" ? 3600 : 5)) do
      @posts = Post.where(:is_published => true)
    end
    render 'rss/index'
  end
end
