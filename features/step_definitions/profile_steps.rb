When(/I visit my profile page/) do
  visit dashboard_path
  within '.navigation' do
    click_link I18n.t('navigation.profile')
  end
end

Then(/^I should see my own activity$/) do
  page_has_workout1
end

When(/^I visit "(.*?)"’s profile$/) do |name|
  visit members_path
  click_link name
end
