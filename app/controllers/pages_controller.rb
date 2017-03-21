class PagesController < ApplicationController
  before_action :set_website
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_website_owner, only: [:new, :create, :edit, :update, :destroy]
  layout 'website'

  # GET /pages
  def index
    @pages = Page.all
  end

  # GET /pages/1
  def show
    @page = Page.includes(:widgets).find(params[:id])
    @widget = Widget.new
    @image = Widget.new
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit; end

  # POST /pages
  def create
    @page = @website.pages.build(page_params)
    if @page.save
      redirect_to website_page_path(@website, @page, locale: I18n.locale), notice: t('.page_succes')
    else
      render :new
    end
  end

  # PATCH/PUT /pages/1
  def update
    if @page.update(page_params)
      redirect_to website_page_path(@website, @page, locale: I18n.locale), notice: t('.page_updated')
    else
      render :edit
    end
  end

  # DELETE /pages/1
  def destroy
    @page.destroy
    redirect_to website_pages_path(@website, locale: I18n.locale), notice: t('.page_destroyed')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find(params[:id])
  end

  def set_website
    @website = Website.find(params[:website_id])
  end

  def check_website_owner
    @website = Website.find(params[:website_id])
    redirect_to root_path unless current_user == @website.user
  end

  # Only allow a trusted parameter "white list" through.
  def page_params
    params.require(:page).permit(:website_id,
                                 :title,
                                 :content,
                                 :layout_id)
  end
end
