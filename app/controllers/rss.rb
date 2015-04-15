TokyoProject.controllers :rss do
  get :index, :provides => [:rss] do
    @cached_pictures = cache("rss_pictures", expires_in: (Padrino.env.to_s == "production" ? 3600 : 5)) do
      @pictures_array = Picture.published.last(20).collect{|picture| [picture, picture.vision]}
    end

    @cached_posts = cache("rss_posts", expires_in: (Padrino.env.to_s == "production" ? 3600 : 5)) do
      @posts = Post.where(:is_published => true)
    end
    render 'rss/index'
  end
end
