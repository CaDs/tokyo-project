TokyoProject.controllers :visions do

  after do
    ActiveRecord::Base.connection.close
  end

  get :show, :map => '/visions/:id', :cache => true do
    expires_in 1 #Caching for 5 minutes
    @vision = Vision.find(params[:id])
    render 'visions/show'
  end

  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

end
