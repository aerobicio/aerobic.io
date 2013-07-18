Given(/^I have a registered account$/) do
  create_registered_account
end

When(/^I log in with valid credentials$/) do
  login
end

Then(/^I should be logged in$/) do
  page.should have_content(@name)
end

When(/^I log in with invalid credentials$/) do
  login("not a real password")
end

Then(/^I should not be logged in$/) do
  page.should have_no_content(@name)
  current_path.should == sign_in_path
end

Given(/^I am logged in$/) do
  create_registered_account
  login
end

When(/^I log out$/) do
  click_link(I18n.t("sign_out"))
end
