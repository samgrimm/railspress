require "rails_helper"
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe NavbarsController, type: :routing do
  describe "routing" do
    before do
      DatabaseCleaner.clean
      @user  = FactoryGirl.create(:user)
      @website =  FactoryGirl.create(:website, user_id: @user.id)
      login_as(@user, :scope => :user)
    end

    it "routes to #index" do
      expect(:get => "websites/#{@website.id}/navbars").to route_to(controller: "navbars", action: "index", website_id: @website.id.to_s)
    end

    it "routes to #new" do
      expect(:get => "websites/#{@website.id}/navbars/new").to route_to(controller: "navbars", action: "new", website_id: @website.id.to_s)
    end

    it "routes to #show" do
      expect(:get => "websites/#{@website.id}/navbars/1").to route_to(controller: "navbars", action: "show", website_id: @website.id.to_s, :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "websites/#{@website.id}/navbars/1/edit").to route_to(controller: "navbars", action: "edit", website_id: @website.id.to_s, :id => "1")
    end

    it "routes to #create" do
      expect(:post => "websites/#{@website.id}/navbars").to route_to(controller: "navbars", action: "create", website_id: @website.id.to_s)
    end

    it "routes to #update via PUT" do
      expect(:put => "websites/#{@website.id}/navbars/1").to route_to(controller: "navbars", action: "update", website_id: @website.id.to_s, :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "websites/#{@website.id}/navbars/1").to route_to(controller: "navbars", action: "update", website_id: @website.id.to_s, :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "websites/#{@website.id}/navbars/1").to route_to(controller: "navbars", action: "destroy", website_id: @website.id.to_s, :id => "1")
    end

  end
end
