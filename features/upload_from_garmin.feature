@garmin @javascript
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
    When I upload a FIT workout from my device
    Then I should see the workout in my activity feed

  Scenario: Uploading a TCX file from a device
    Given I am a member
    When I upload a TCX workout from my device
    Then I should see the workout in my activity feed

  Scenario: Uploading multiple files from a device
    Given I am a member
    When I upload a multiple workouts from my device
    Then I should see the workouts in my activity feed

  Scenario: Uploading fails
    Given I am a member
    When I upload a FIT workout from my device
    And there was a problem with the upload
    Then I should see an error message for the upload
