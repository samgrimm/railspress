require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :deletion

describe "choose page layout" do
  before do
    @user  = FactoryGirl.create(:user)
    @website =  FactoryGirl.create(:website, user_id: @user.id)
    @page  = FactoryGirl.create(:page, website_id: @website.id)
    @layout1 = FactoryGirl.create(:layout, name: "layout1", image:"layout1.png")
    @layout2 = FactoryGirl.create(:layout, name: "layout2", image:"layout2.png")
    @layout3 = FactoryGirl.create(:layout, name: "layout3", image:"layout.3png")
    login_as(@user, :scope => :user)
  end
  it "displays to the user the available layouts" do
    visit edit_website_page_path(@website, @page, locale: 'en')
    expect(page.find("#page_layout_id_#{@layout1.id}")).to be_truthy
    expect(page.find("#page_layout_id_#{@layout2.id}")).to be_truthy
    expect(page.find("#page_layout_id_#{@layout3.id}")).to be_truthy
    choose("page_layout_id_#{@layout1.id}")
    click_on(I18n.t('pages.edit.update'))
    expect(page.find(".page_layout_1")).to be_truthy
  end
  it "displays to the user change the page layout" do
    visit edit_website_page_path(@website, @page, locale: 'en')
    expect(page.find("#page_layout_id_#{@layout1.id}")).to be_truthy
    expect(page.find("#page_layout_id_#{@layout2.id}")).to be_truthy
    expect(page.find("#page_layout_id_#{@layout3.id}")).to be_truthy
    choose("page_layout_id_#{@layout2.id}")
    click_on(I18n.t('pages.edit.update'))
    expect(page.find(".page_layout_2")).to be_truthy
  end
end
