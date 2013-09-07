Feature: Styleguide
  In order to keep our CSS from becoming unweildy
  As a developer
  I want to be able to be able to view the styleguide

  Scenario: "Viewing the styleguide"
    Given I have documented my CSS
    Then I should be able to browse rule classifications in the styleguide

  Scenario: "Viewing specific component examples"
    Given I have documented my CSS
    Then I should be able to view an example for each component
