Feature: Creating Archives

  Background:
    Given the User visits '/archives'

  @javascript @use_db
  Scenario: Creating a new Archive
    When the User clicks on the "New Archive" button
    And enters the new Archive's title
    And clicks on "Create Archive"
    Then a new Archive with given title should be created
