class NavbarsController < ApplicationController
  before_action :set_website
  before_action :set_navbar, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  layout 'website'
  # GET /navbars
  def index
    @navbars = Navbar.all
  end
  # GET /navbars/1
  def show
  end

  # GET /navbars/new
  def new
    @navbar = Navbar.new
  end

  # GET /navbars/1/edit
  def edit
  end

  # POST /navbars
  def create
      @navbar = @website.navbars.build(navbar_params)
    if @navbar.save
      redirect_to website_navbars_path(@website,locale:I18n.locale), notice: t(".navbar_succes")
    else
      render :new
    end
  end
  # PATCH/PUT /navbars/1
  def update
    if @navbar.update(navbar_params)
      redirect_to website_navbars_path(@website,locale:I18n.locale), notice: t(".navbar_updated")
    else
      render :edit
    end
  end
  # DELETE /navbars/1
  def destroy
    @navbar.destroy
    redirect_to website_navbars_url(@website, locale: I18n.locale), notice: t(".navbar_destroyed")
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_navbar
      @navbar = Navbar.find(params[:id])
    end
    def set_website
      @website = Website.find(params[:website_id])
    end

    # Only allow a trusted parameter "white list" through.
    def navbar_params
      params.require(:navbar).permit(:title, :nav_style_id, :website_id, :position)
    end
end
