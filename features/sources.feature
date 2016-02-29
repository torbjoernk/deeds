Feature: Sources

  Background:
    Given a Source exists
    And the User visits '/sources'

  Scenario: Index table
    Then the User should see a table with sources

  @javascript
  Scenario: Creating a new Source
    When the User clicks on the "New Source" button
    And enters the new Source's title
    And enters the new Source's type
    And clicks on "Create Source"
    Then a new Source with given title and type should be created

  @javascript
  Scenario: Show details of a single Source
    When the User clicks on the "Show" button of the first Source
    Then the User should see the Source's details

  @javascript
  Scenario: Edit details of a single Source
    When the User clicks on the "Edit" button of the first Source
    And changes the Source's title
    And clicks on "Update Source"
    Then the Source's title should be changed to the new value

  @javascript
  Scenario: Delete a single Source
    When the User clicks on the 'Delete' button of the first Source and accepts the confirmation
    Then the Source should get deleted

  @javascript
  Scenario: Abort deletion of a single Source
    When the User clicks on the 'Delete' button of the first Source and dismisses the confirmation
    Then the Source should be kept
