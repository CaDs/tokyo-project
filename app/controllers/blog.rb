TokyoProject::TokyoProject.controllers :blog do

  get :index do
    key = "blog"
    cache(key, expires_in: (Padrino.env.to_s == "production" ? 3600 : 1)) do
      @posts = Post.where("is_published = true").order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
      render 'blog/index'
    end
  end

  get :show, :with => :id do
    key = "blog_show_#{params[:id]}"
    cache(key, expires_in: (Padrino.env.to_s == "production" ? 3600 : 1)) do
      @post = Post.find(params[:id])
      render 'blog/show'
    end
  end

end