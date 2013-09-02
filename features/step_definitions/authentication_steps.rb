Given(/^I have a registered account$/) do
  create_registered_account
end

When(/^I sign in with valid credentials$/) do
 sign_in
end

Then(/^I should be signed in$/) do
  page.should have_selector("body.authenticated")
end

When(/^I sign in with invalid credentials$/) do
  sign_in("not a real password")
end

Then(/^I should not be signed in$/) do
  page.should have_selector("body.unauthenticated")
end

Given(/^I am signed in$/) do
  create_registered_account
  sign_in
end

When(/^I sign out$/) do
  click_link(I18n.t("sign_out"))
end
