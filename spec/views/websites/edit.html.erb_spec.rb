require 'rails_helper'

RSpec.describe "websites/edit", type: :view do
  before(:each) do
    @website = assign(:website, Website.create!(
      :name => "MyString",
      :description => "MyText",
      :user => nil
    ))
  end

  it "renders the edit website form" do
    render

    assert_select "form[action=?][method=?]", website_path(@website), "post" do

      assert_select "input#website_name[name=?]", "website[name]"

      assert_select "textarea#website_description[name=?]", "website[description]"

      assert_select "input#website_user_id[name=?]", "website[user_id]"
    end
  end
end
