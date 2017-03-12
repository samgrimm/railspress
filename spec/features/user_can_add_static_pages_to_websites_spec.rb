require 'rails_helper'

describe 'navigate' do

  describe 'index' do
    before do
      @user  = FactoryGirl.create(:user)
      @website =  FactoryGirl.create(:website, user_id: @user.id)
      @page  = FactoryGirl.create(:page, website_id: @website.id)
      login_as(@user, :scope => :user)
    end
    it 'can be reached successfully' do
      visit website_pages_path(@website, locale: 'en')
      expect(page.status_code).to eq(200)
    end

    it 'has a title of My Pages' do
      visit website_pages_path(@website, locale: 'en')
      expect(page).to have_content(I18n.t('pages.index.Pages'))
    end

    it 'has a list of Pages' do
      second_page = FactoryGirl.create(:page, website_id: @website.id, title:"My Second Page")

      visit website_pages_path(@website, locale: 'en')
      expect(page).to have_text("My Second Page")
      expect(page).to have_text("My First Page")
    end

    it "shows only that website's pages" do
      second_page = FactoryGirl.create(:page, website_id: @website.id, title:"My Second Page")
      second_website = FactoryGirl.create(:website, name:"My Second Website", user_id: @user.id)
      third_page = FactoryGirl.create(:page, website_id: second_website.id, title:"My Third Page")
      visit website_pages_path(@website, locale: 'en')
      expect(page).to have_content(/My First Page|My Second Page/)
      expect(page).not_to have_content(/My Thrid Page/)
    end
    describe "new" do
      it "has a link from the website_pages_path" do
        visit website_pages_path(@website, locale: 'en')
        expect(page).to have_link('add_page')
        click_link "add_page"
        expect(page.status_code).to eq(200)
      end
    end
  end

  describe "delete" do
    before do
      @user  = FactoryGirl.create(:user)
      @website =  FactoryGirl.create(:website, user_id: @user.id)
      @page = FactoryGirl.create(:page, website_id: @website.id, title:"My Second Page")
      login_as(@user, :scope => :user)
    end
    it "can be deleted" do
      visit website_pages_path(@website, locale: 'en')
      click_link "delete_#{@page.id}"
      expect(page.status_code).to eq(200)
    end
  end

  describe "creation" do
    before do
      @user  = FactoryGirl.create(:user)
      @website =  FactoryGirl.create(:website, user_id: @user.id)
      @page = FactoryGirl.create(:page, website_id: @website.id, title:"My Second Page")
      login_as(@user, :scope => :user)
      visit new_website_page_path(@website, locale: 'en')
    end
    it "has a new form that can be reached" do
      expect(page.status_code).to eq(200)
    end
    it "can be created from new form page" do
      fill_in 'page[title]', with: "My Amazing Website"
      fill_in 'page[content]', with: "Some amazing description goes here"
      expect { click_on(I18n.t('pages.new.create')) }.to change(Page, :count).by(1)
    end

    it "will have a website associated with the page" do
      fill_in 'page[title]', with: "My Home Page"
      fill_in 'page[content]', with: "webbie_association"
      click_on(I18n.t('pages.new.create'))

      expect(Page.last.content).to eq("webbie_association")
    end
    it "can only be created by the website's owner" do
      logout(:user)
      non_auth_user = FactoryGirl.create(:non_auth_user)
      login_as(non_auth_user, :scope => :user)
      visit new_website_page_path(@website, locale: 'en')
      expect(current_path).to eq(root_path)
    end
  end

  describe "edit" do
    before do
      @user  = FactoryGirl.create(:user)
      @website =  FactoryGirl.create(:website, user_id: @user.id)
      @page = FactoryGirl.create(:page, website_id: @website.id, title:"My Second Page")
      login_as(@user, :scope => :user)
    end
    it "can be reached by clicking edit on the index page" do
      visit website_pages_path(@website, locale: 'en')
      click_link "edit_#{@page.id}"
      expect(page.status_code).to eq(200)
    end
    it "can be edited" do
      visit edit_website_page_path(@website, @page, locale: 'en')
      fill_in 'page[title]', with: "My Home Page"
      fill_in 'page[content]', with: "webbie_association"
      click_on(I18n.t('pages.edit.update'))
      expect(page).to have_content("webbie_association")
    end

    it "cannot be edited by an unauthorized user" do
      logout(:user)
      non_auth_user = FactoryGirl.create(:non_auth_user)
      login_as(non_auth_user, :scope => :user)
      visit edit_website_page_path(@website, @page, locale: 'en')
      expect(current_path).to eq(root_path)
    end
  end
end
