TokyoProject.controllers :visions do

  after do
    ActiveRecord::Base.connection.close
  end

  get :index, :map => '/visions' do
    key = "visions"
    cache(key, expires_in: (Padrino.env.to_s == "production" ? 3600 : 1)) do
      @visions = Vision.order("created_at DESC").all.find_all{|v| v.pictures.any?}
      render 'visions/index'
    end
  end

  get :show, :map => '/visions/:id(/:pid)' do
    key = "vision_show_#{params[:id]}"
    key += "_#{params[:pid]}" if params[:pid]

    cache(key, expires_in: (Padrino.env.to_s == "production" ? 3600 : 1)) do
      @vision = Vision.find(params[:id]) rescue nil
      if @vision
        @pictures = @vision.published_pictures
        @picture = @pictures.find{|p| p.id == params[:pid].to_i} if params[:pid] rescue nil
        @picture ||= @vision.published_pictures.first
        render 'visions/show'
      else
        flash[:notice] = "Vision not founded"
        redirect url(:areas, :index)
      end
    end #cache
  end

end