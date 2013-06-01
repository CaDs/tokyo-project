TokyoProject.controllers :rss do
  get :index, :provides => [:rss] do
    @pictures = Picture.where(:is_published => true)
    render 'rss/index'
  end
end
