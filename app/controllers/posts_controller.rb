class PostsController < ApplicationController
  before_action :set_website
  before_action :set_blog
  before_action :check_website_owner, only: [:new, :create, :edit, :update, :destroy, :toggle_status]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :toggle_status]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :toggle_status]
  # GET /posts
  def index
    @posts = @blog.posts
  end

  # GET /posts/1
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  def create
    @post = @blog.posts.build(post_params)
    if @post.save
      redirect_to website_blog_post_path(@website, @blog, @post, locale: I18n.locale), notice: t('.post_succes')
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to website_blog_post_path(@website, @blog, @post, locale: I18n.locale), notice: t('.post_updated')
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to website_blog_posts_path(@website, @blog, locale: I18n.locale), notice: t('.post_destroyed')
  end

  def toggle_status
    @post.toggle_status
    redirect_to website_blog_posts_path(@website, @blog, locale: I18n.locale), notice: t('.success')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_website
    @website = Website.find(params[:website_id])
  end

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

  def check_website_owner
    @website = Website.find(params[:website_id])
    redirect_to root_path unless current_user == @website.user
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:title, :content, :status, :blog_id)
  end
end
