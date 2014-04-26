Given(/^I have added a workout$/) do
  upload_default_workout
end

When(/^I visit the workout page from the activity feed$/) do
  visit dashboard_path
  page_has_workout1

  activity_panel = page.find('[data-href]', text: I18n.t('activity.title.html',
    member_link: 'You',
    verb: 'added',
    action_link: I18n.t('activity.added_workout.title.cycling')
  ))
  activity_panel.click
end

Then(/^I should see my workout$/) do
  page_has_workout1
end
