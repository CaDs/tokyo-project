TokyoProject.controllers :areas do
  get :index do
    @visions = Vision.all
    render 'areas/index'
  end

  get :show, :with => :id do
    @area = Area.find(params[:id])
    @visions = @area.visions
    render 'areas/show'
  end

end
