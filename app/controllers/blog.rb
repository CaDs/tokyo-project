# frozen_string_literal: true
TokyoProject::App.controllers :blog do
  get :index do
    key = 'blog'
    cache_time = Padrino.env == :production ? 86_400 : 1
    cache(key, expires: cache_time) do
      page ||= 1
      @posts = Post.where('is_published = true').order('created_at DESC').page(page).per(10)
      render 'blog/index'
    end
  end

  get :show, with: :id do
    key = "blog_show_#{params[:id]}"
    cache_time = Padrino.env == :production ? 86_400 : 1
    cache(key, expires: cache_time) do
      @post = Post.find(params[:id])
      render 'blog/show'
    end
  end
end
