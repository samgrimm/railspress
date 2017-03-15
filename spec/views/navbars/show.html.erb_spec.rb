require 'rails_helper'

RSpec.describe "navbars/show", type: :view do
  before(:each) do
    @navbar = assign(:navbar, Navbar.create!(
      :title => "Title",
      :style => "Style",
      :website => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Style/)
    expect(rendered).to match(//)
  end
end
