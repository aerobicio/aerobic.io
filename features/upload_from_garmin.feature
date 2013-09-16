Feature: Upload From Garmin
  In order to track my workouts
  As a registered user
  I want to be able to upload files from my Garmin

  Scenario: Uploading a FIT file from a device
    Given I am signed in
    When I upload a FIT file from a device
    Then I should see workout information on my dashboard
