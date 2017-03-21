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
    xit "with a link to an add widget form"  do
      @page = FactoryGirl.create(:page, website_id: website.id, title:"My Second Page")
      @page.reload
      visit website_page_path(website, @page, locale: 'en')
      fill_in 'Title', with: "Hello "
      fill_in 'Content', with: "I am a widget"
      click_on(I18n.t('widgets.widget_form.post_widget'))
      expect(Text.count).to eq(1)
    end

    it "with different types" do

    end
  end

  describe 'editing' do
    it "can be done from the page itself" do
      @page = FactoryGirl.create(:page, website_id: website.id, title:"My Second Page")
      widget = FactoryGirl.create(:widget, type: 'Text', widgetable_id: @page.id, widgetable_type: 'Page', title:"My First Widget")
      @page.reload
      visit website_page_path(website, @page, locale: 'en')
      click_on("edit_widget_#{widget.id}")
      fill_in 'New Title', with: "My best widget"
      click_on(I18n.t('widgets.widget_form.post_widget'))
      expect(page).to have_content('My best widget')
    end
  end

  describe "can be added to posts" do

  end
  describe "can be added to sidebar" do

  end
end
