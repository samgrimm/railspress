class LinksController < ApplicationController
  before_action :set_website
  before_action :set_navbar


  # POST /links
  def create
    @link = @navbar.links.build(link_params)
    if @link.save
      redirect_to website_navbar_path(@website, @navbar, locale:I18n.locale), notice: t(".link_succes")
    else
      render :new
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to website_navbars_url(@website, locale: I18n.locale), notice: t(".link_destroyed")
  end

  private

  def set_navbar
    @navbar = Navbar.find(params[:navbar_id])
  end
  def set_website
    @website = Website.find(params[:website_id])
  end

  # Only allow a trusted parameter "white list" through.
  def link_params
    params.permit(:display_name, :page_id)
  end
end
