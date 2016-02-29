Feature: Index Page

  Scenario: Basic Layout
    Given the User visits '/'
    Then the User should see "Hello World"

  Scenario: Main Menu Bar
    Given the User visits '/'
    Then the User should see the main menu bar at the top

  Scenario: Breadcrumbs
    Given the User visits '/'
    Then the User should see the breadcrumbs with "Home"
