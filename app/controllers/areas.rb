TokyoProject.controllers :areas do
  after do
    ActiveRecord::Base.connection.close
  end

  get :index do
    key = 'areas'
    cache(key, expires_in: (Padrino.env.to_s == "production" ? 3600 : 1)) do
      content_for(:meta_description) { "A tour around alleys, parks, temples. Get lost and discover new faces of Tokyo by walking around it areas."}
      content_for(:title) { "Areas" }
      @areas = Area.order("created_at DESC").scoped.find_all{|a| a.visions.any? && a.visions.sum {|v| v.published_pictures.size} > 0}
      render 'areas/index'
    end
  end

  get :show, :map => '/areas/:id(/:pid)' do
    key =  "area_show_#{params[:id]}"
    cache(key, expires_in: (Padrino.env.to_s == "production" ? 3600 : 1)) do
      @area = Area.find(params[:id]) rescue nil
      @area ||= Area.find_by_url_title(params[:id]) rescue nil
      content_for(:meta_description) { "#{@area.description}"}
      content_for(:title) { @area.name }
      @visions = @area.visions.find_all{|v| v.published_pictures.any?}
      render 'areas/show'
    end
  end

end
