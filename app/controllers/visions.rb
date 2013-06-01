TokyoProject.controllers :visions do

  after do
    ActiveRecord::Base.connection.close
  end

  get :show, :map => '/visions/:id(/:pid)', :cache => true do
    key = "vision_show_#{params[:id]}"
    key += "_#{pid}" if params[:pid]
    cache_key key
    expires_in(Padrino.env.to_s == "production" ? 3600 : 1)

    @vision = Vision.find(params[:id]) rescue nil
    if @vision
      @pictures = @vision.published_pictures
      @picture = @pictures.find(params[:pid]) if params[:pid] rescue nil
      @picture ||= @vision.pictures.first
      render 'visions/show'
    else
      flash[:notice] = "Vision not founded"
      redirect url(:areas, :index)
    end
  end

end
