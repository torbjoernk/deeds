Feature: Storages

  Background:
    Given a Storage exists

  Scenario: Index table
    When the User visits '/storages'
    Then the User should see a table with storages

  @javascript
  Scenario: Show details of a single Storage
    When the User visits '/storages'
    And the User clicks on the 'Show' button of the first Storage
    Then the User should see the Storage's details
