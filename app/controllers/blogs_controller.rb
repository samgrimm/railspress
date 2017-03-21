class BlogsController < ApplicationController
  before_action :set_website
  before_action :authenticate_user!
  before_action :check_website_owner, only: [:new, :create, :destroy]
  layout 'website'

  # GET /blogs/new
  def new
    if @website.blog.nil?
      @blog = Blog.new
    else
      redirect_to website_blog_posts_path(@website, @website.blog, locale: I18n.locale)
    end
  end

  # POST /blogs
  def create
    @blog = @website.build_blog
    if @blog.save
      redirect_to website_blog_posts_path(@website, @blog, locale: I18n.locale), notice: t('.blog_succes')
    else
      render :new
    end
  end

  private

  def set_website
    @website = Website.find(params[:website_id])
  end

  def check_website_owner
    @website = Website.find(params[:website_id])
    redirect_to root_path unless current_user == @website.user
  end
end
