Given(/^I have a registered account$/) do
  create_registered_account
  click_link(I18n.t("sign_out"))
end

When(/^I sign in with valid credentials$/) do
 sign_in
end

Then(/^I should be signed in$/) do
  page.should have_content(@name)
  current_path.should == root_path
end

When(/^I sign in with invalid credentials$/) do
  sign_in("not a real password")
end

Then(/^I should not be signed in$/) do
  page.should have_no_content(@name)
  current_path.should == sign_in_path
end

Given(/^I am a member$/) do
  create_registered_account
  sign_in
end

When(/^I sign out$/) do
  click_link(I18n.t("sign_out"))
end
