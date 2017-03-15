require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :deletion

describe "adding a navbar" do
  before do
    @user  = FactoryGirl.create(:user)
    @website =  FactoryGirl.create(:website, user_id: @user.id)
    @page = FactoryGirl.create(:page, website: @website, title: "Page 1")
    @page2 = FactoryGirl.create(:page, website: @website, title: "Page 2")
    @page3 = FactoryGirl.create(:page, website: @website, title: "Page 3")
    login_as(@user, :scope => :user)
  end

  it "allows user to add a navbar" do
    visit new_website_navbar_path(@website, locale: 'en')
    click_on(I18n.t('navbars.new.create'))
    expect(@website.navbars.count).to eq(1)
    expect(page).to have_content("Choose the pages to add to your navbar")
    expect(page).to have_content("Page 3")
    expect(page).to have_content("Page 1")
    expect(page).to have_content("Page 2")
  end
end

describe "adding items to the navbar" do
  before do
    @user  = FactoryGirl.create(:user)
    @website =  FactoryGirl.create(:website, user_id: @user.id)
    @page = FactoryGirl.create(:page, website: @website, title: "page1")
    @page2 = FactoryGirl.create(:page, website: @website, title: "page2")
    @page3 = FactoryGirl.create(:page, website: @website, title: "page3")
    login_as(@user, :scope => :user)
  end

  it "allows user to add items to the navbar" do
    @navbar = FactoryGirl.create(:navbar, website:@website, title: "Main Nav")
    @navbar.reload
    visit website_navbar_path(@website, @navbar, locale: 'en')
    click_on("add_page_#{@page3.id}")
    expect(@navbar.pages.first.title).to eq('page3')
  end
end

describe "showing the navbar" do
  before do
    @user  = FactoryGirl.create(:user)
    @color_combo1 = FactoryGirl.create(:color_combo, name: "Combo1")
    @website =  FactoryGirl.create(:website, user_id: @user.id, color_combo: @color_combo1)
    @page = FactoryGirl.create(:page, website: @website, title: "Page 1")
    @page2 = FactoryGirl.create(:page, website: @website, title: "Page 2")
    @page3 = FactoryGirl.create(:page, website: @website, title: "Page 3")
    login_as(@user, :scope => :user)
  end

  it "when there is no navbar user sees the link to add one" do
    visit website_path(@website, locale: 'en')
    expect(page).not_to have_content("Page 3")
    expect(page).not_to have_content("Page 1")
    expect(page).not_to have_content("Page 2")
    expect(page).to have_content(I18n.t('websites.show.add_nav'))
  end

  it "when there is navbar user sees navbar and link to edit" do
    @navbar = FactoryGirl.create(:navbar, website: @website, title: "Default Nav")
    pages = [@page, @page2, @page3]
    pages.each do |page|
      @navbar.links.create(page_id: page.id)
    end
    @navbar.reload
    visit website_path(@website, locale: 'en')
    expect(page).to have_content("Page 3")
    expect(page).to have_content("Page 1")
    expect(page).to have_content("Page 2")
    expect(page).to have_content(I18n.t('websites.show.edit_nav'))
  end
end

describe "deleting navbars" do
  before do
    @user  = FactoryGirl.create(:user)
    @website =  FactoryGirl.create(:website, user_id: @user.id)
    @page = FactoryGirl.create(:page, website: @website, title: "Page 1")
    @page2 = FactoryGirl.create(:page, website: @website, title: "Page 2")
    @page3 = FactoryGirl.create(:page, website: @website, title: "Page 3")
    @navbar = FactoryGirl.create(:navbar, website: @website, title: "Main Nav")
    login_as(@user, :scope => :user)
  end

  it "user sees the navbar" do
    visit website_navbars_path(@website, locale: 'en')
    expect(page).to have_content(I18n.t('navbars.index.delete'))
    click_on(I18n.t('navbars.index.delete'))
    expect(@website.navbars.count).to eq(0)
  end
end
