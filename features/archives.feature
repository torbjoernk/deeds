@use_db
Feature: Displaying Archives

  Background:
    Given an Archive exists
    And the User visits '/archives'

  Scenario: Index table
    Then the User should see a table with archives

  Scenario: Breadcrumbs
    Then the User should see the breadcrumbs with "Home"
    Then the User should see the breadcrumbs with "Archives"

  @javascript
  Scenario: Show details of a single Archive
    When the User clicks on the 'Show' button of the first Archive
    Then the User should see the Archives's details
