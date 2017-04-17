# frozen_string_literal: true
TokyoProject::App.controllers :blog do
  get :index do
    cache_key 'blog'
    expires(Padrino.env == :production ? 86_400 : 60)

    page ||= 1
    @posts = Post.where('is_published = true').order('created_at DESC').page(page).per(10)
    render 'blog/index'
  end

  get :show, with: :id do
    cache_key "blog_show_#{params[:id]}"
    expires(Padrino.env == :production ? 86_400 : 60)

    @post = Post.find(params[:id])
    render 'blog/show'
  end
end
