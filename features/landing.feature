Feature: LandingPage
  I want to see the landing page to welcome everyone who access to Tokyo Project

  Scenario: Visitor lands into Tokyo Project
    Given I am viewing '/'
    Then I should see 'Tokyo Project'
