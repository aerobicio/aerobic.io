When(/^I visit the upload page$/) do
  visit upload_path
end

When(/^I add a workout$/) do
  upload_default_workout
end

Then(/^I should see workout information on my dashboard$/) do
  visit dashboard_path
  page.should have_content 'Distance: 41.32km'
end

Then(/^I should see a message telling me that I have no devices$/) do
  page.should have_content 'Uh oh, we couldn’t find any devices!'
end

Given(/^I have a Garmin device that supports FIT files$/) do
  member_has_fit_device
  page_has_device
end

Given(/^I have some FIT workouts on my device$/) do
  member_fit_workouts_on_device
end

When(/^I upload a FIT workout from my device$/) do
  select_device_with_name('Test FIT Device')

  within '#Workouts' do
    page_has_workouts

    workout = get_workout_node_for_workout(@workouts.first)

    workout.click

    within workout do
      page.find('input[type=checkbox]').should be_checked
    end

    upload_button = find_button('Upload Workouts (1)')
    upload_button.click
  end
end

When(/^I upload multiple workouts from my device$/) do
  select_device_with_name('Test FIT Device')

  within '#Workouts' do
    page_has_workouts

    workout1 = get_workout_node_for_workout(@workouts.first)
    workout1.click
    within workout1 do
      page.find('input[type=checkbox]').should be_checked
    end

    workout2 = get_workout_node_for_workout(@workouts.last)
    workout2.click
    within workout2 do
      page.find('input[type=checkbox]').should be_checked
    end

    upload_button = find_button('Upload Workouts (2)')
    upload_button.click
  end
end

Then(/^I should see the workouts in my activity feed$/) do
  visit dashboard_path
  page_has_workout1
  page_has_workout2
end

Given(/^I have a Garmin device that supports TCX files$/) do
  member_has_tcx_device
end

Given(/^I have some TCX workouts on my device$/) do
  member_tcx_workouts_on_device
end

Given(/^I have a FIT workout that cannot be parsed on my device$/) do
  member_bad_data_workouts_on_device
end

When(/^I upload a TCX workout from my device$/) do
  select_device_with_name('Test TCX Device')

  within '#Workouts' do
    page_has_workouts

    workout = get_workout_node_for_workout(@workouts.first)

    workout.click

    within workout do
      page.find('input[type=checkbox]').should be_checked
    end

    upload_button = find_button('Upload Workouts (1)')
    upload_button.click
  end
end

Then(/^the workout should be uploaded$/) do
  within '#Workouts' do
    ensure_workout_upload_succeeds(@workouts.first[:uuid])
  end
end

Then(/^the workouts should both be uploaded$/) do
  within '#Workouts' do
    ensure_workout_upload_succeeds(@workouts.first[:uuid])
    ensure_workout_upload_succeeds(@workouts.last[:uuid])
  end
end

Then(/^I should see an error message for the upload$/) do
  within '#Workouts' do
    ensure_workout_upload_fails(@workouts.first[:uuid])
  end
end

When(/^I select the device$/) do
  select_device_with_name('Test FIT Device')
end

Then(/^I should see a message telling me there are no workouts on my device$/) do
  page.should have_content 'We couldn’t find any workouts — better go training!'
end

Then(/^I should see a message telling me that I need to install the Garmin plugin$/) do
  page.should have_content 'Go and install the garmin plugin!'
end

def page_has_workouts
  page.should have_content "#{@workouts.length} Workouts found on your device."

  @workouts.map do|workout|
    page.should have_css("[data-workout-uuid='#{workout[:uuid]}']")
  end
end

def ensure_workout_upload_succeeds(uuid)
  Capybara.default_wait_time = 15
  newWorkout = page.find(".is-uploaded[data-workout-uuid='#{uuid}']")
  within newWorkout do
    page.should have_content('uploaded')
  end
  Capybara.default_wait_time = 2
end

def ensure_workout_upload_fails(uuid)
  Capybara.default_wait_time = 15
  newWorkout = page.find(".is-failed[data-workout-uuid='#{uuid}']")
  within newWorkout do
    page.should have_content('failed')
  end
  Capybara.default_wait_time = 2
end

def select_device_with_name(name)
  within '#DevicesList' do
    page_has_device
    page.find('.devices-list__device', text: name).click
  end
end

def get_workout_node_for_workout(workout)
  page.find("[data-workout-uuid='#{workout[:uuid]}']")
end

def page_has_device
  page.should have_css('.devices-list__device')
end
