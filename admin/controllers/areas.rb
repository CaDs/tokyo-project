Admin.controllers :areas do

  get :index do
    @areas = Area.all
    render 'areas/index'
  end

  get :new do
    @area = Area.new
    @wards = Ward.all
    render 'areas/new'
  end

  post :create do
    @area = Area.new(params[:area])
    if @area.save
      flash[:notice] = 'Area was successfully created.'
      redirect url(:areas, :edit, :id => @area.id)
    else
      render 'areas/new'
    end
  end

  get :edit, :with => :id do
    @area = Area.find(params[:id])
    @wards = Ward.all
    render 'areas/edit'
  end

  put :update, :with => :id do
    @area = Area.find(params[:id])
    if @area.update_attributes(params[:area])
      flash[:notice] = 'Area was successfully updated.'
      redirect url(:areas, :edit, :id => @area.id)
    else
      render 'areas/edit'
    end
  end

  delete :destroy, :with => :id do
    area = Area.find(params[:id])
    if area.destroy
      flash[:notice] = 'Area was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Area!'
    end
    redirect url(:areas, :index)
  end
end
