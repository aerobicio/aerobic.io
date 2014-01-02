Feature: Workouts
  In order to review my training
  As a registered member
  I can view the workouts that I have uploaded

  Scenario: Viewing a workout from the activity feed
    Given I am a member
    And I have added a workout
    When I visit the workout page from the activity feed
    Then I should see my workout
