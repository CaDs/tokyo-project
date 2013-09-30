TokyoProject::TokyoProject.controllers :maps do
  
  get :show, :map => '/maps/:id(/:pid)' do
    @vision = Vision.find(params[:id])
    map_data = @vision.map_data
    @map_url = map_data['url']
    @map_legend = map_data['legend']
    render 'maps/show'
  end

end
