When(/^I go to the website page$/) do
  @user = FactoryGirl.create(:user, password: 'foobar')
  @color_combo = FactoryGirl.create(:color_combo, name: 'combo1')
  @website = FactoryGirl.create(:website, user: @user, color_combo: @color_combo)
  visit new_user_session_path
  fill_in 'user_email', with: @user.email
  fill_in 'user_password', with: 'foobar'
  click_button 'Login'
  visit website_path(@website)
end

Then(/^the page background should be teal$/) do
  color = page.evaluate_script("$('#main_div').css('background-color')")
  color.should == '#009999'
end
