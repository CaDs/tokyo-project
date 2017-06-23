# frozen_string_literal: true

TokyoProject::App.controllers :visions do
  after do
    ActiveRecord::Base.connection.close
  end

  get :index, map: '/visions' do
    key = 'visions'
    cache_time = Padrino.env == :production ? 86_400 : 60

    cache(key, expires: cache_time) do
      @visions = Vision.order('created_at DESC').find_all { |v| v.published_pictures.any? }
      content_for(:meta_description) { 'Unique moments and places captured around Tokyo' }
      content_for(:title) { 'Visions' }
      render 'visions/index'
    end
  end

  get :show, map: '/visions/:id(/:pid)?' do
    key = "vision_show_#{params[:id]}"
    key += "_#{params[:pid]}" if params[:pid]
    cache_time = Padrino.env == :production ? 86_400 : 60

    cache(key, expires: cache_time) do
      @vision = Vision.preload(:pictures, :area).find(params[:id]) rescue nil
      @vision ||= Vision.find_by_url_title(URI.encode(params[:id]))

      content_for(:meta_description) { @vision.meta_description.present? ? @vision.meta_description : @vision.short_description }
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
        render 'visions/show'
      else
        flash[:notice] = 'Vision not found'
        redirect url(:areas, :index)
      end
    end # cache
  end
end
