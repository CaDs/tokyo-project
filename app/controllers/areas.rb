TokyoProject.controllers :areas do
  after do
    ActiveRecord::Base.connection.close
  end

  get :index do
    key = 'areas'
    cache(key, expires_in: (Padrino.env.to_s == "production" ? 3600 : 1)) do
      @areas = Area.order("created_at DESC").all.find_all{|a| a.visions.any?}
      render 'areas/index'
    end
  end

  get :show, :with => :id do
    key =  "area_show_#{params[:id]}"
    cache(key, expires_in: (Padrino.env.to_s == "production" ? 3600 : 1)) do
      @area = Area.find(params[:id])
      @visions = @area.visions.find_all{|v| v.published_pictures.any?}
      render 'areas/show'
    end
  end

end
