require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :deletion

describe 'user sees a dashboard when logged in' do
  let(:user) { FactoryGirl.create(:user) }
  let(:color_combo1) { FactoryGirl.create(:color_combo, name: 'Combo1') }
  let(:website) { FactoryGirl.create(:website, user_id: user.id, color_combo_id: color_combo1.id) }
  let(:navbar) { FactoryGirl.create(:navbar, website: website) }
  let(:footer) { FactoryGirl.create(:navbar, website: website, position: 'footer') }
  before do
    login_as(user, scope: :user)
  end
  it 'contains a sidebar with navigation to the website features' do
    visit website_path(website, locale: 'en')
    expect(page).to have_content('Navbars')
    expect(page).to have_content('Pages')
    expect(page).to have_content('Blog')
    expect(page).to have_content('Widgets')
    expect(page).to have_content('Dev View/Guest View')
  end

  it 'allows user to toggle views between owner and guest without signing out', js: true do
    visit website_path(website, locale: 'en')
    click_on('Toggle View')
    expect(page).not_to have_content('Navbars')
    expect(page).not_to have_content('Pages')
    expect(page).not_to have_content('Blog')
    expect(page).not_to have_content('Widgets')
    expect(page).not_to have_content('RailsCMS')
  end
  it 'allows user to edit the website content while having access to the sidebar' do
    @page = FactoryGirl.create(:page, website_id: website.id)
    @page.reload
    visit edit_website_page_path(website, @page, locale: 'en')

    fill_in 'page[title]', with: 'My Home Page'
    fill_in 'page[content]', with: 'webbie_association'
    click_on(I18n.t('pages.edit.update'))
    expect(page).to have_content('webbie_association')
    expect(page).to have_content('Navbars')
    expect(page).to have_content('Pages')
    expect(page).to have_content('Blog')
    expect(page).to have_content('Widgets')
    expect(page).to have_content('Dev View/Guest View')
  end
end
