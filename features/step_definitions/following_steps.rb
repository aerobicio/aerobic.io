Given(/^"(.*?)" is following me$/) do |name|
  Capybara.session_name = name
  create_registered_account(name)
  follow(@my_name)
  Capybara.session_name = 'mine'
end

Given(/^I am following "(.*?)"$/) do |name|
  follow(name)
end

Given(/^I am not following "(.*?)"$/) do |name|
  # This is the default state
end

When(/^I follow "(.*?)"$/) do |name|
  Capybara.session_name = name
  create_registered_account(name)
  Capybara.session_name = 'mine'

  follow(name)
end

Then(/^I should see that fact in my activity feed$/) do
  visit dashboard_path
  page.should have_content "You followed #{@name}"
end

Then(/^"(.*?)" should see that I followed them in their activity feed$/) do |name|
  Capybara.session_name = name
  visit dashboard_path
  page.should have_content I18n.t('activity.title.html',
                                  member_link: @my_name,
                                  verb: 'followed',
                                  action_link: 'You'
                                 )
end

Then(/^"(.*?)" should see that I followed "(.*?)" in their activity feed$/) do |name, followed_name|
  Capybara.session_name = name
  visit dashboard_path
  page.should have_content "#{@my_name} followed #{followed_name}"
end

When(/^I unfollow "(.*?)"$/) do |name|
  @name = name
  visit members_path
  click_button "Unfollow #{name}"
end

Then(/^I should see that I unfollowed "(.*?)" in my activity feed$/) do |name|
  visit dashboard_path
  page.should have_content I18n.t('activity.title.html',
                                  member_link: 'You',
                                  verb: 'unfollowed',
                                  action_link: name
                                 )
end

Then(/^"(.*?)" should not see that fact in their activity feed$/) do |name|
  Capybara.session_name = name
  visit dashboard_path
  page.should have_no_content "#{@my_name} is no longer following you"
end

def follow(name)
  @name = name
  visit members_path
  click_button "Follow #{name}"
end
