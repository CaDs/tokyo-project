TokyoProject.controllers :site do
  enable :caching

  get :index do
    render'site/index'
  end

end
