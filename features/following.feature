Feature: Following
  In order to see what my friends are doing
  As a member
  I want to be able to follow other members

  Background:
    Given I am a member
    And "Justin" is following me

  @flip @following @off
  Scenario: A member cannot unfollow another member when the feature is off
    Given I am following "Justin"
    And the following feature is off
    Then I should not be able to unfollow "Justin"

  @flip @following @off
  Scenario: A member cannot follow another member when the feature is off
    Given I am not following "Justin"
    And the following feature is off
    Then I should not be able to follow "Justin"

  @flip @following @on
  Scenario: A member can follow another member when the feature is on
    Given the following feature is on
    When I follow "Gus"
    Then I should see that fact in my activity feed
    And "Gus" should see that I followed them in their activity feed
    And "Justin" should see that I followed "Gus" in their activity feed

  @flip @following @on @wip
  Scenario: A member can unfollow another member when the feature is on
    Given the following feature is on
    And I follow "Gus" 
    When I unfollow "Gus"
    Then I should see that I unfollowed "Gus" in my activity feed
    And "Gus" should not see that fact in their activity feed
    And "Justin" should not see that fact in their activity feed
