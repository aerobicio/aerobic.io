Given(/^I have a white listed email address$/) do
  @email = Identity::WHITE_LIST.first
  @name = "White Listed"
end

When(/^I sign up$/) do
  visit sign_up_path
  fill_in :name, with: @name
  fill_in :email, with: @email
  fill_in :password, with: 123456789
  fill_in :password_confirmation, with: 123456789

  click_button(I18n.t("identities.new.submit"))
end

Given(/^I have a non white listed email address$/) do
  @email = "something@example.com"
  @name = "Not White Listed"
end

Then(/^I should be told I am not on the beta list$/) do
  page.should have_content("Email is not included in the beta list")
end
