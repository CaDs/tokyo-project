# frozen_string_literal: true

TokyoProject::App.controllers :places do
  after do
    ActiveRecord::Base.connection.close
  end

  get :index, map: '/places' do
    key = 'places'
    cache_time = Padrino.env == :production ? 86_400 : 10

    cache(key, expires: cache_time) do
      @visions = Vision.eager_load(:pictures)
                       .where('pictures.is_published = true')
                       .order('visions.created_at DESC')
      content_for(:meta_description) { 'Unique moments and places captured around Tokyo' }
      content_for(:title) { 'Visions' }
      render 'places/index'
    end
  end

  get :show, map: '/places/:id(/:pid)?' do
    key = "places_show_#{params[:id]}"
    key += "_#{params[:pid]}" if params[:pid]
    cache_time = Padrino.env == :production ? 86_400 : 60

    cache(key, expires: cache_time) do
      @vision = Vision.preload(:pictures, :area).find(params[:id]) rescue nil
      @vision ||= Vision.find_by_url_title(URI.encode(params[:id]))

      content_for(:meta_description) do
        if @vision.meta_description.present?
          @vision.meta_description
        else
          @vision.short_description
        end
      end

      content_for(:meta_keywords) { @vision.meta_keywords }
      content_for(:title) { @vision.title }
      if @vision
        @pictures = @vision.published_pictures
        begin
          @picture = @pictures.find { |p| p.id == params[:pid].to_i } if params[:pid]
        rescue
          nil
        end
        @picture ||= @vision.published_pictures.first
        render 'places/show'
      else
        flash[:notice] = 'Vision not found'
        redirect url(:areas, :index)
      end
    end # cache
  end
end
