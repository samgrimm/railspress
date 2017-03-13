class WebsitesController < ApplicationController
  before_action :set_website, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :check_website_owner, only: [:edit, :update, :destroy ]
  layout 'website', only: :show
  # GET /websites
  def index
    @websites = current_user.websites
  end
  # GET /websites/1
  def show
  end

  # GET /websites/new
  def new
    @website = Website.new
  end

  # GET /websites/1/edit
  def edit
  end

  # POST /websites
  def create
      @website = current_user.websites.build(website_params)
    if @website.save
      redirect_to website_path(@website, locale:I18n.locale), notice: t(".website_succes")
    else
      render :new
    end
  end
  # PATCH/PUT /websites/1
  def update
    if @website.update(website_params)
      redirect_to website_path(@website, locale:I18n.locale), notice: t(".website_updated")
    else
      render :edit
    end
  end
  # DELETE /websites/1
  def destroy
    @website.destroy
    redirect_to websites_url(locale: I18n.locale), notice: t(".website_destroyed")
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_website
      @website = Website.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def website_params
      params.require(:website).permit(:name, :description, :color_combo_id)
    end

    def check_website_owner
      @website = Website.find(params[:id])
      redirect_to root_path unless current_user == @website.user
    end
end
