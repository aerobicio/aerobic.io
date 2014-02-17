Given(/^the sign up feature is active$/) do
  $switch_board.activate_sign_up
end

When(/^I sign up with valid credentials$/) do
  email = 'something@example.com'
  name = 'Someone Awesome'

  sign_up(name, email)
end

When(/^I sign up with invalid credentials$/) do
  email = 'something@com'
  name = 'Someone Awesome'

  sign_up(name, email)
end

Then(/^I should be on the sign up page$/) do
  current_path.should == '/auth/identity/register'
end

Then(/^I should see error messages$/) do
  page.should have_content('Email is not a valid email')
end

Given(/^the sign up feature is not active$/) do
  $switch_board.deactivate_sign_up
end

When(/^I visit the sign up page$/) do
  visit sign_in_path
end

Then(/^I should be redirected to the sign in page$/) do
  current_path.should == sign_in_path
end

Then(/^I should not see the sign up link$/) do
  page.should have_no_content(sign_up_text)
end

def sign_up(name, email)
  visit root_path
  click_link(sign_up_text)

  fill_in :name, with: name
  fill_in :email, with: email
  fill_in :password, with: '123456789'
  fill_in :password_confirmation, with: '123456789'

  click_button(sign_up_text)
end

def sign_up_text
  I18n.t('identities.new.submit')
end
