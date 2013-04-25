TokyoProject.controllers :rss do
  get :index, :provides => [:rss] do
    @pictures = Picture.all
    render 'rss/index'
  end
end
