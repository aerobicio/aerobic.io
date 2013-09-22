Feature: Following
  In order to see what my friends are doing
  As a member
  I want to be able to follow other members

  @flip @following @off
  Scenario: A member cannot unfollow another member when the feature is off
    Given the following feature is off
    And I am following another member
    Then I should not be able to unfollow them

  @flip @following @off
  Scenario: A member cannot follow another member when the feature is off
    Given the following feature is off
    And I am not following another member
    Then I should not be able to follow them

  @flip @following @on
  Scenario: A member can follow another member when the feature is on
    Given the following feature is on
    When I follow another member
    Then I should see that fact in my activity feed
    And members who follow me should see that fact in their activity feed

  @flip @following @on
  Scenario: A member can be followed by another member when the feature is on
    Given the following feature is on
    When another member follows me
    Then I should see that fact in my activity feed

  @flip @following @on
  Scenario: A member can unfollow another member when the feature is on
    Given the following feature is on
    When another member unfollows me
    Then I should not see that fact in my activity feed

  @flip @following @on
  Scenario: A member can unfollow another member when the feature is on
    Given the following feature is on
    And I am following another member
    When I unfollow another member
    Then I should see that fact in my activity feed
    And members who follow me should not see that fact in their activity feed

  @following @activity
  Scenario: A member should not see activies of other members they do not follow
    Given I am not following another member
    When they add a workout
    Then I should not see it in my activity feed

  @following @activity
  Scenario: A member should see activities of other members they follow
    Given I am following another member
    When they add a workout
    Then I should see it in my activity feed

