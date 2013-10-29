TokyoProject::TokyoProject.controllers :blog do

  get :index do
    @posts = Post.where("is_published = true").order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    render 'blog/index'
  end

  get :show, :with => :id do
    @post = Post.find(params[:id])
    render 'blog/show'
  end


end
