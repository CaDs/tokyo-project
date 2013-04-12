Admin.controllers :pictures do

  get :index do
    @pictures = Picture.all
    render 'pictures/index'
  end

  get :new do
    @picture = Picture.new
    @visions = Vision.all
    render 'pictures/new'
  end

  post :create do
    @picture = Picture.new(params[:picture])
    if @picture.save
      flash[:notice] = 'Picture was successfully created.'
      redirect url(:pictures, :edit, :id => @picture.id)
    else
      render 'pictures/new'
    end
  end

  get :edit, :with => :id do
    @picture = Picture.find(params[:id])
    @visions = Vision.all
    render 'pictures/edit'
  end

  put :update, :with => :id do
    @picture = Picture.find(params[:id])
    if @picture.update_attributes(params[:picture])
      flash[:notice] = 'Picture was successfully updated.'
      redirect url(:pictures, :edit, :id => @picture.id)
    else
      render 'pictures/edit'
    end
  end

  delete :destroy, :with => :id do
    picture = Picture.find(params[:id])
    if picture.destroy
      flash[:notice] = 'Picture was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Picture!'
    end
    redirect url(:pictures, :index)
  end
end
