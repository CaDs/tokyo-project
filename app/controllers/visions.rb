TokyoProject.controllers :visions do

  after do
    ActiveRecord::Base.connection.close
  end

  get :show, :map => '/visions/:id(/:pid)' do
    key = "vision_show_#{params[:id]}"
    key += "_#{params[:pid]}" if params[:pid]
    cache(key: key, expires_in: (Padrino.env.to_s == "production" ? 3600 : 1)) do
      # cache_key key
      @vision = Vision.find(params[:id]) rescue nil
      if @vision
        @pictures = @vision.published_pictures
        @picture = @pictures.find(params[:pid]).first if params[:pid] rescue nil
        @picture ||= @vision.pictures.first
        render 'visions/show'
      else
        flash[:notice] = "Vision not founded"
        redirect url(:areas, :index)
      end
    end #cache
  end

end