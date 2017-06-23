# frozen_string_literal: true

TokyoProject::Admin.controllers :pictures do
  get :index do
    @pictures = Picture.order('created_at DESC').page(params[:page]).per(10)
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
      redirect url(:pictures, :edit, id: @picture.id)
    else
      flash[:error] = 'Picture is not valid.'
      redirect url(:pictures, :new)
    end
    @picture.clear_cache
  end

  get :edit, with: :id do
    @picture = Picture.find(params[:id])
    @visions = Vision.all
    render 'pictures/edit'
  end

  put :update, with: :id do
    @picture = Picture.find(params[:id])
    if @picture.update_attributes(params[:picture])
      @picture.reload
      @picture.clear_cache
      if @picture.schedule_at
        PictureJob.new.async.schedule(@picture.seconds_to_publish, @picture.id)
      end
      flash[:notice] = 'Picture was successfully updated.'
      redirect url(:pictures, :edit, id: @picture.id)
    else
      render 'pictures/edit'
    end
  end

  delete :destroy, with: :id do
    picture = Picture.find(params[:id])
    vision = picture.vision
    if picture.destroy
      vision.clear_cache
      flash[:notice] = 'Picture was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Picture!'
    end
    redirect url(:pictures, :index)
  end
end
