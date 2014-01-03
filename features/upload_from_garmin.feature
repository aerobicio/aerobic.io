@javascript
Feature: Upload From Garmin
  In order to track my workouts
  As a registered member
  I want to be able to upload files from my Garmin

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
    Then I should see the workout in my activity feed

  # Scenario: Uploading a TCX file from a device
  #   Given I am a member
  #   And I visit the upload page
  #   And I have a Garmin device that supports TCX files
  #   And I have some TCX workouts on my device
  #   When I upload a TCX workout from my device
  #   Then I should see the workout in my activity feed

  Scenario: Uploading multiple files from a device
    Given I am a member
    And I visit the upload page
    And I have a Garmin device that supports FIT files
    And I have some FIT workouts on my device
    When I upload multiple workouts from my device
    Then I should see the workouts in my activity feed

  # Scenario: Device has no workouts
  #   Given I am a member
  #   And I visit the upload page
  #   And I have a Garmin device that supports FIT files
  #   Then I should see a message telling me there are no workouts on my device

  # Scenario: Uploading fails
  #   Given I am a member
  #   And I visit the upload page
  #   And I have a Garmin device that supports FIT files
  #   And I have a FIT file that cannot be parsed
  #   When I upload a FIT workout from my device
  #   And it fails to upload properly
  #   Then I should see an error message for the upload
