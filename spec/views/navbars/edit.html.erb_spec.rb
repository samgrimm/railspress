require 'rails_helper'

RSpec.describe "navbars/edit", type: :view do
  before(:each) do
    @navbar = assign(:navbar, Navbar.create!(
      :title => "MyString",
      :style => "MyString",
      :website => nil
    ))
  end

  it "renders the edit navbar form" do
    render

    assert_select "form[action=?][method=?]", navbar_path(@navbar), "post" do

      assert_select "input#navbar_title[name=?]", "navbar[title]"

      assert_select "input#navbar_style[name=?]", "navbar[style]"

      assert_select "input#navbar_website_id[name=?]", "navbar[website_id]"
    end
  end
end
