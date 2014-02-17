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
    And I visit the upload page
    And I have a Garmin device that supports FIT files
    And I have some FIT workouts on my device
    When I upload a FIT workout from my device
    Then the workout should be uploaded

  Scenario: Uploading a TCX file from a device
    Given we have implemented TCX parsing server-side
    Given I am a member
    And I visit the upload page
    And I have a Garmin device that supports TCX files
    And I have some TCX workouts on my device
    When I upload a TCX workout from my device
    Then the workout should be uploaded

  Scenario: Uploading multiple files at once from a device
    Given I am a member
    And I visit the upload page
    And I have a Garmin device that supports FIT files
    And I have some FIT workouts on my device
    When I upload multiple workouts from my device
    Then the workouts should both be uploaded

  Scenario: Device has no workouts
    Given I am a member
    And I visit the upload page
    And I have a Garmin device that supports FIT files
    When I select the device
    Then I should see a message telling me there are no workouts on my device

  Scenario: Uploading fails
    Given we have implemented less explosive handling of failing uploads
    Given I am a member
    And I visit the upload page
    And I have a Garmin device that supports FIT files
    And I have a FIT workout that cannot be parsed on my device
    When I upload a FIT workout from my device
    Then I should see an error message for the upload
