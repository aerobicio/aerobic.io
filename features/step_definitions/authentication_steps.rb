Given(/^I have a registered account$/) do
  @password = 123456789
  @identity = FactoryGirl.create(:identity,
                                 password: @password,
                                 password_confirmation: @password)
  @name = @identity.name
end

When(/^I log in with valid credentials$/) do
  visit sign_in_path
  fill_in "Email", with: @identity.email
  fill_in :password, with: @password

  click_button "Login"
end

Then(/^I should be logged in$/) do
  page.should have_content(@name)
end

When(/^I log in with invalid credentials$/) do
  visit sign_in_path
  fill_in "Email", with: @identity.email
  fill_in :password, with: "not a real password"

  click_button "Login"
end

Then(/^I should not be logged in$/) do
  page.should have_no_content(@name)
  current_path.should == sign_in_path
end

Given(/^I am logged in$/) do
  @password = 123456789
  @identity = FactoryGirl.create(:identity,
                                 password: @password,
                                 password_confirmation: @password)
  @name = @identity.name

  visit sign_in_path
  fill_in "Email", with: @identity.email
  fill_in :password, with: @password

  click_button "Login"
end

When(/^I log out$/) do
  click_link "sign out"
end
