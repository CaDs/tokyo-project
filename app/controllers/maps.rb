TokyoProject::TokyoProject.controllers :maps do

  get :show, :map => '/maps/:id' do
    key = "maps_show_#{params[:id]}"

    cache(key, expires_in: (Padrino.env.to_s == "production" ? 3600 : 1)) do
      @vision = Vision.find(params[:id])
      map_data = @vision.map_data
      @static_map_url = map_data['static_url']
      @dynamic_map_url = map_data['dynamic_url']
      @map_legend = map_data['legend']
      render 'maps/show'
    end
  end

end
