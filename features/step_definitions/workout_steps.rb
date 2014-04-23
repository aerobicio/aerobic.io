Given(/^I have added a workout$/) do
  upload_default_workout
end

When(/^I visit the workout page from the activity feed$/) do
  visit dashboard_path

  page_has_workout1
  page.find('[data-href]', text: I18n.t('activity.workout.title.cycling', name: I18n.t('you'))).click
end

Then(/^I should see my workout$/) do
  page_has_workout1
end
