# frozen_string_literal: true
TokyoProject::Admin.controllers :wards do
  get :index do
    @wards = Ward.all
    render 'wards/index'
  end

  get :new do
    @ward = Ward.new
    render 'wards/new'
  end

  post :create do
    @ward = Ward.new(params[:ward])
    if @ward.save
      flash[:notice] = 'Ward was successfully created.'
      redirect url(:wards, :edit, id: @ward.id)
    else
      render 'wards/new'
    end
  end

  get :edit, with: :id do
    @ward = Ward.find(params[:id])
    render 'wards/edit'
  end

  put :update, with: :id do
    @ward = Ward.find(params[:id])
    if @ward.update_attributes(params[:ward])
      flash[:notice] = 'Ward was successfully updated.'
      redirect url(:wards, :edit, id: @ward.id)
    else
      render 'wards/edit'
    end
  end

  delete :destroy, with: :id do
    ward = Ward.find(params[:id])
    if ward.destroy
      flash[:notice] = 'Ward was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Ward!'
    end
    redirect url(:wards, :index)
  end
end
