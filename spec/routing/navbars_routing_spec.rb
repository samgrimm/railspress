require "rails_helper"

RSpec.describe NavbarsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/navbars").to route_to("navbars#index")
    end

    it "routes to #new" do
      expect(:get => "/navbars/new").to route_to("navbars#new")
    end

    it "routes to #show" do
      expect(:get => "/navbars/1").to route_to("navbars#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/navbars/1/edit").to route_to("navbars#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/navbars").to route_to("navbars#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/navbars/1").to route_to("navbars#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/navbars/1").to route_to("navbars#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/navbars/1").to route_to("navbars#destroy", :id => "1")
    end

  end
end
