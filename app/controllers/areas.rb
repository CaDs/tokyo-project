TokyoProject.controllers :areas do
  after do
    ActiveRecord::Base.connection.close
  end

  get :index, :cache => true do
    cache_key 'areas'
    expires_in(Padrino.env.to_s == "production" ? 3600 : 1)

    @visions = Vision.order("created_at DESC").all
    render 'areas/index'
  end

  get :show, :with => :id, :cache => true do
    cache_key "area_show_#{params[:id]}"
    expires_in(Padrino.env.to_s == "production" ? 3600 : 1)

    @area = Area.find(params[:id])
    @visions = @area.visions
    render 'areas/show'
  end

end
