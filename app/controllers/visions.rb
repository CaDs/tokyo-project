TokyoProject.controllers :visions do

  after do
    ActiveRecord::Base.connection.close
  end

  get :show, :map => '/visions/:id(/:pid)', :cache => false do
    # expires_in 1 #Caching for 5 minutes
    @vision = Vision.find(params[:id])
    @pictures = @vision.pictures
    @picture = Picture.find(params[:pid]) if params[:pid]
    render 'visions/show'
  end

end
