# frozen_string_literal: true

TokyoProject::App.controllers :maps do
  get :show, map: '/maps/:id' do
    key = "maps_show_#{params[:id]}"
    cache_time = Padrino.env == :production ? 86_400 : 60

    cache(key, expires: cache_time) do
      @vision = Vision.find(params[:id])
      map_data = @vision.map_data
      @static_map_url = map_data['static_url']
      @dynamic_map_url = map_data['dynamic_url']
      @map_legend = map_data['legend']
      render 'maps/show'
    end
  end
end
