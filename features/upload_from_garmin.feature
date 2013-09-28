Feature: Upload From Garmin
  In order to track my workouts
  As a registered user
  I want to be able to upload files from my Garmin

  Scenario: Uploading a FIT file from a device
    Given I am a member
    When I add a workout
    Then I should see the workout in my activity feed
