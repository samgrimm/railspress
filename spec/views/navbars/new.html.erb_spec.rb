require 'rails_helper'

RSpec.describe "navbars/new", type: :view do
  before(:each) do
    assign(:navbar, Navbar.new(
      :title => "MyString",
      :style => "MyString",
      :website => nil
    ))
  end

  it "renders new navbar form" do
    render

    assert_select "form[action=?][method=?]", navbars_path, "post" do

      assert_select "input#navbar_title[name=?]", "navbar[title]"

      assert_select "input#navbar_style[name=?]", "navbar[style]"

      assert_select "input#navbar_website_id[name=?]", "navbar[website_id]"
    end
  end
end
