@whatson @whatson_tags
Feature: Whatson Post Tags
  Whatson posts can be assigned tags
  
  Background:
    Given I am a logged in refinery user
  
  Scenario: The whatson post new/edit form has tag_list
    When I am on the new whatson post form
    Then I should see "Tags"
    
  Scenario: The whatson post new/edit form saves tag_list
    When I am on the new whatson post form
    And I fill in "Title" with "This is my whatson post"
    And I fill in "whatson_post_body" with "And I love it"
    And I fill in "Tags" with "chicago, bikes, beers, babes"
    And I press "Save"

    Then there should be 1 whatson post
    And the whatson post should have the tags "chicago, bikes, beers, babes"
    
  Scenario: The whatson has a "tagged" route & view
    Given there is a whatson post titled "I love my city" and tagged "chicago"
    When I visit the tagged posts page for "chicago"
    Then I should see "Chicago"
    And I should see "I love my city"