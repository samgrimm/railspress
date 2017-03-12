require 'rails_helper'

RSpec.describe "websites/new", type: :view do
  before(:each) do
    assign(:website, Website.new(
      :name => "MyString",
      :description => "MyText",
      :user => nil
    ))
  end

  it "renders new website form" do
    render

    assert_select "form[action=?][method=?]", websites_path, "post" do

      assert_select "input#website_name[name=?]", "website[name]"

      assert_select "textarea#website_description[name=?]", "website[description]"

      assert_select "input#website_user_id[name=?]", "website[user_id]"
    end
  end
end
