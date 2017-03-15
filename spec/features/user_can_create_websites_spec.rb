require 'rails_helper'

describe 'navigate' do
  let(:user) { FactoryGirl.create(:user) }
  let(:website) { FactoryGirl.create(:website, user_id: user.id) }
  let(:color_combo1) { FactoryGirl.create(:color_combo, name: "Combo1") }
  let(:color_combo2) { FactoryGirl.create(:color_combo, name: "Combo2",) }
  let(:color_combo3) { FactoryGirl.create(:color_combo, name: "Combo3") }
  describe 'index' do
    before do
      login_as(user, :scope => :user)
    end
    it 'can be reached successfully' do
      visit websites_path
      expect(page.status_code).to eq(200)
    end

    it 'has a title of My Websites' do
      visit websites_path
      expect(page).to have_content(I18n.t('websites.index.Websites'))
    end

    it 'has a list of Websites' do
      website
      second_website = FactoryGirl.create(:website, name:"My Second Website")
      second_website.update!(user_id: user.id)

      visit websites_path
      expect(page).to have_text("My Second Website")
      expect(page).to have_text("My First Website")
    end

    it "has a scope so that only website creators can see their websites" do
      other_user = FactoryGirl.create(:non_auth_user)
      website1 = FactoryGirl.create(:website, user_id: user.id)
      second_website = FactoryGirl.create(:website, name:"My Second Website")
      second_website.update!(user_id: user.id)
      website_from_other_user = FactoryGirl.create(:website, name:"Another Webbie", user_id: other_user.id)
      visit websites_path
      expect(page).to have_content(/My First Website|My Second Website/)
      expect(page).not_to have_content(/Another Webbie/)
    end
    describe "new" do
      it "has a link from the websites_path" do
        visit websites_path
        expect(page).to have_link('add_website')
        click_link "add_website"
        expect(page.status_code).to eq(200)
      end
    end
  end

  describe "delete" do
    before do
      @user = FactoryGirl.create(:user)
      @website = FactoryGirl.create(:website, user_id: @user.id)
      login_as(@user, :scope => :user)
    end
    it "can be deleted" do
      visit websites_path
      click_link "delete_#{@website.id}"
      expect(page.status_code).to eq(200)
    end
  end

  describe "creation" do
    before do
      @color_combo1 = FactoryGirl.create(:color_combo, name: "Combo1")
      @color_combo2 = FactoryGirl.create(:color_combo, name: "Combo2",)
      @color_combo3 = FactoryGirl.create(:color_combo, name: "Combo3")
      login_as(user, :scope => :user)
      visit new_website_path
    end
    it "has a new form that can be reached" do
      expect(page.status_code).to eq(200)
    end
    it "can be created from new form page" do
      fill_in 'website[name]', with: "My Amazing Website"
      fill_in 'website[description]', with: "Some amazing description goes here"
      choose("website_color_combo_id_#{@color_combo1.id}")
      expect { click_on(I18n.t('websites.new.create')) }.to change(Website, :count).by(1)
    end

    it "will have an user associated with the post" do
      fill_in 'website[name]', with: "My Amazing Website"
      fill_in 'website[description]', with: "user_association"
      choose("website_color_combo_id_#{@color_combo1.id}")
      click_on(I18n.t('websites.new.create'))

      expect(User.last.websites.last.description).to eq("user_association")
    end
  end

  describe "edit" do
    before do
      @color_combo1 = FactoryGirl.create(:color_combo, name: "Combo1")
      @color_combo2 = FactoryGirl.create(:color_combo, name: "Combo2",)
      @color_combo3 = FactoryGirl.create(:color_combo, name: "Combo3")
      @user = FactoryGirl.create(:user)
      @website = FactoryGirl.create(:website, user_id: @user.id, color_combo: @color_combo1)
      login_as(@user, :scope => :user)
    end
    it "can be reached by clicking edit on the index page" do
      visit websites_path
      click_link "edit_#{@website.id}"
      expect(page.status_code).to eq(200)
    end
    it "can be edited" do
      visit edit_website_path(@website, locale: 'en')
      fill_in 'website[name]', with: "Date.today"
      fill_in 'website[description]', with: "Edited work_performed"
      click_on(I18n.t('websites.edit.update'))
      expect(page).to have_content("Edited work_performed")
    end

    it "cannot be edited by an unauthorized user" do
      logout(:user)
      non_auth_user = FactoryGirl.create(:non_auth_user)
      login_as(non_auth_user, :scope => :user)
      visit edit_website_path(@website, locale: 'en')
      expect(current_path).to eq(root_path)
    end
  end
end
