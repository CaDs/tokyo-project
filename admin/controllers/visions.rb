Admin.controllers :visions do

  get :index do
    @visions = Vision.order(:id).find_all{|v| v.published_pictures.count > 0}.paginate(:page => params[:page], :per_page => 10)
    render 'visions/index'
  end

  get :new do
    @vision = Vision.new
    @areas = Area.all
    render 'visions/new'
  end

  post :create do
    @vision = Vision.new(params[:vision])
    @vision.account = current_account
    if @vision.save
      flash[:notice] = 'Vision was successfully created.'
      redirect url(:visions, :edit, :id => @vision.id)
    else
      render 'visions/new'
    end
  end

  get :edit, :with => :id do
    @vision = Vision.find(params[:id])
    @areas = Area.all
    render 'visions/edit'
  end

  put :update, :with => :id do
    @vision = Vision.find(params[:id])
    if @vision.update_attributes(params[:vision])
      flash[:notice] = 'Vision was successfully updated.'
      redirect url(:visions, :edit, :id => @vision.id)
    else
      render 'visions/edit'
    end
  end

  delete :destroy, :with => :id do
    vision = Vision.find(params[:id])
    if vision.destroy
      flash[:notice] = 'Vision was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Vision!'
    end
    redirect url(:visions, :index)
  end
end
