@javascript @poltergeist
Feature: Upload From Garmin
  In order to track my workouts
  As a registered member
  I want to be able to upload files from my Garmin

  @no-garmin
  Scenario: The Garmin plugin is not installed in my browser
    Given I am a member
    When I visit the upload page
    Then I should see a message telling me that I need to install the Garmin plugin

  Scenario: I have no devices
    Given I am a member
    When I visit the upload page
    Then I should see a message telling me that I have no devices

  Scenario: Uploading a FIT file from a device
    Given I am a member
    When I add a workout using a FIT file
    Then I should see the workout in my activity feed
    And I visit the upload page
    And I have a Garmin device that supports FIT files
    And I have some FIT workouts on my device
    When I upload a FIT workout from my device
    Then the workout should be uploaded
    And I should see the workout in my activity feed

  Scenario: Uploading a TCX file from a device
    Given I am a member
    And I visit the upload page
    And I have a Garmin device that supports TCX files
    And I have some TCX workouts on my device
    When I upload a TCX workout from my device
    Then the workout should be uploaded
    And I should see the workout in my activity feed

  Scenario: Uploading multiple files at once from a device
    Given I am a member
    And I visit the upload page
    And I have a Garmin device that supports FIT files
    And I have some FIT workouts on my device
    When I upload multiple workouts from my device
    Then the workouts should both be uploaded
    And I should see the workouts in my activity feed

  Scenario: Device has no workouts
    Given I am a member
    And I visit the upload page
    And I have a Garmin device that supports FIT files
    When I select the device
    Then I should see a message telling me there are no workouts on my device

  # This scenario does actually pass in theory, however at the moment throwing
  # bad data like this at the uploads_controller fails very explosively.
  #
  # Need to work out how to have it explode but still respond to the user in a
  # better way. Need to talk to @quamen about this...
  #
  # Scenario: Uploading fails
  #   Given I am a member
  #   And I visit the upload page
  #   And I have a Garmin device that supports FIT files
  #   And I have a FIT workout that cannot be parsed on my device
  #   When I upload a FIT workout from my device
  #   Then I should see an error message for the upload
