require 'rails_helper'

RSpec.describe "pages/edit", type: :view do
  before(:each) do
    @page = assign(:page, Page.create!(
      :website => nil,
      :title => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit page form" do
    render

    assert_select "form[action=?][method=?]", page_path(@page), "post" do

      assert_select "input#page_website_id[name=?]", "page[website_id]"

      assert_select "input#page_title[name=?]", "page[title]"

      assert_select "textarea#page_content[name=?]", "page[content]"
    end
  end
end
