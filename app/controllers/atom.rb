TokyoProjectng::App.controllers :atom do
  get :index, provides: [:atom] do
    @pictures = Picture.all
    render 'atom/index'
  end
end
