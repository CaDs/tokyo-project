# frozen_string_literal: true

TokyoProject::App.controllers :areas do
  after do
    ActiveRecord::Base.connection.close
  end

  get :index do
    key = 'areas'
    cache_time = Padrino.env == :production ? 86_400 : 10
    cache(key, expires: cache_time) do
      content_for(:meta_description) { 'A tour around alleys, parks, temples. Get lost and discover new faces of Tokyo by walking around it areas.' }
      content_for(:title) { 'Areas' }
      @areas = Area.eager_load(:visions)
                   .eager_load(visions: :pictures)
                   .order('areas.created_at DESC')
                   .where("visions.id is not null and pictures.id is not null")
      render 'areas/index'
    end
  end

  get :show, map: '/areas/:id(/:pid)?' do
    key = "area_show_#{params[:id]}"
    cache_time = Padrino.env == :production ? 86_400 : 60
    cache(key, expires: cache_time) do
      @area = Area.find(params[:id]) rescue nil
      @area ||= Area.find_by_url_title(URI.encode(params[:id])) rescue nil

      content_for(:meta_description) { @area.description.to_s }
      content_for(:title) { @area.name }
      @visions = @area.visions.find_all { |v| v.published_pictures.any? }
      render 'areas/show'
    end
  end
end
