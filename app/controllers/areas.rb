# frozen_string_literal: true
TokyoProject::App.controllers :areas do
  after do
    ActiveRecord::Base.connection.close
  end

  get :index do
    cache_key 'areas'
    expires(Padrino.env == :production ? 86_400 : 60)

    content_for(:meta_description) { 'A tour around alleys, parks, temples. Get lost and discover new faces of Tokyo by walking around it areas.' }
    content_for(:title) { 'Areas' }
    @areas = Area.order('created_at DESC').find_all { |a| a.visions.any? && a.visions.sum { |v| v.published_pictures.size } > 0 }
    render 'areas/index'
  end

  get :show, map: '/areas/:id(/:pid)?' do
    cache_key "area_show_#{params[:id]}"
    expires(Padrino.env == :production ? 86_400 : 60)

    @area = Area.find(params[:id]) rescue nil
    @area ||= Area.find_by_url_title(URI.encode(params[:id])) rescue nil

    content_for(:meta_description) { @area.description.to_s }
    content_for(:title) { @area.name }
    @visions = @area.visions.find_all { |v| v.published_pictures.any? }
    render 'areas/show'
  end
end
