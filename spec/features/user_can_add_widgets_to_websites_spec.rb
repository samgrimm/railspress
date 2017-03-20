require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :deletion

describe "widgets" do
    let(:user) { FactoryGirl.create(:user) }
    let(:color_combo1) { FactoryGirl.create(:color_combo, name: "Combo1") }
    let(:website) { FactoryGirl.create(:website, user_id: user.id, color_combo_id: color_combo1.id) }
    let(:navbar) { FactoryGirl.create(:navbar, website: website) }
    let(:footer) { FactoryGirl.create(:navbar, website: website, position: 'footer') }
  before do
    login_as(user, :scope => :user)
  end
  describe "can be added to pages" do
    it "with a link to an add widget form" , js: true do
      @page = FactoryGirl.create(:page, website_id: website.id, title:"My Second Page")
      @page.reload
      visit edit_website_page_path(website, @page, locale: 'en')
      click_on('add_widget')
      expect(page).to have_content("Add Widget")
      fill_in 'Supertitle', with: "Hello "
      fill_in 'Supercontent', with: "I am a widget"
      fill_in 'Type', with: 'Text'
      click_on(I18n.t('pages.edit.update'))
      save_and_open_page
      expect(Text.count).to eq(1)
    end

    it "with different types" do
      
    end
  end

  describe "can be added to posts" do

  end
  describe "can be added to sidebar" do

  end
end
