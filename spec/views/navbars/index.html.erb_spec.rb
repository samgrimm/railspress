require 'rails_helper'

RSpec.describe "navbars/index", type: :view do
  before(:each) do
    assign(:navbars, [
      Navbar.create!(
        :title => "Title",
        :style => "Style",
        :website => nil
      ),
      Navbar.create!(
        :title => "Title",
        :style => "Style",
        :website => nil
      )
    ])
  end

  it "renders a list of navbars" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Style".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
