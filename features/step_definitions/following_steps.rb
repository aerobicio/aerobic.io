Given(/^"(.*?)" is following me$/) do |name|
  Capybara.session_name = name
  create_registered_account(name)
  follow(@my_name)
  Capybara.session_name = "mine"
end

Given(/^I am following "(.*?)"$/) do |name|
  follow(name)
end

Given(/^the following feature is off$/) do
  $switch_board.deactivate_following
end

Then(/^I should not be able to unfollow "(.*?)"$/) do |name|
  visit members_path
  page.should have_no_content("Unfollow")
end

Given(/^I am not following "(.*?)"$/) do |name|
  # This is the default state
end

Then(/^I should not be able to follow "(.*?)"$/) do |name|
  visit members_path
  page.should have_no_content("Follow")
end

Given(/^the following feature is on$/) do
  $switch_board.activate_following
end

When(/^I follow "(.*?)"$/) do |name|
  Capybara.session_name = name
  create_registered_account(name)
  Capybara.session_name = "mine"

  follow(name)
end

Then(/^I should see that fact in my activity feed$/) do
  $switch_board.activate_following
  visit dashboard_path
  page.should have_content "You followed #{@name}"
  $switch_board.deactivate_following
end

Then(/^"(.*?)" should see that I followed them in their activity feed$/) do |name|
  $switch_board.activate_following
  Capybara.session_name = name
  visit dashboard_path
  page.should have_content "#{@my_name} followed you"
  $switch_board.deactivate_following
end

Then(/^"(.*?)" should see that I followed "(.*?)" in their activity feed$/) do |name, followed_name|
  $switch_board.activate_following
  Capybara.session_name = name
  visit dashboard_path
  page.should have_content "#{@my_name} followed #{followed_name}"
  $switch_board.deactivate_following
end

When(/^I unfollow "(.*?)"$/) do |name|
  $switch_board.activate_following
  @name = name
  visit members_path
  click_button "Unfollow #{name}"
  $switch_board.deactivate_following
end

Then(/^I should see that I unfollowed "(.*?)" in my activity feed$/) do |name|
  $switch_board.activate_following
  visit dashboard_path
  page.should have_content "No longer following #{@name}"
  $switch_board.deactivate_following
end

Then(/^"(.*?)" should not see that fact in their activity feed$/) do |name|
  Capybara.session_name = name
  visit dashboard_path
  page.should have_no_content "#{@my_name} is no longer following you"
end

def follow(name)
  @name = name
  $switch_board.activate_following
  visit members_path
  click_button "Follow #{name}"
  $switch_board.deactivate_following
end

