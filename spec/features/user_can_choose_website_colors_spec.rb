require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :deletion

describe 'choose website colors and styles' do
  before do
    @user = FactoryGirl.create(:user)
    @website = FactoryGirl.create(:website, user_id: @user.id)
    @color_combo1 = FactoryGirl.create(:color_combo, name: 'Combo1')
    @color_combo2 = FactoryGirl.create(:color_combo, name: 'Combo2')
    @color_combo3 = FactoryGirl.create(:color_combo, name: 'Combo3')
    login_as(@user, scope: :user)
  end
  it 'displays to the user the available color combinations to the user' do
    visit edit_website_path(@website, locale: 'en')
    expect(page.find("#website_color_combo_id_#{@color_combo1.id}")).to be_truthy
    expect(page.find("#website_color_combo_id_#{@color_combo2.id}")).to be_truthy
    choose("website_color_combo_id_#{@color_combo1.id}")
    click_on(I18n.t('websites.edit.update'))
    @website.reload
    expect(@website.color_combo.name).to eq('Combo1')
  end
end
