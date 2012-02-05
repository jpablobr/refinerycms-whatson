@whatson @whatson_authors
Feature: Whatson Post Authors
  Whatson posts can be assigned authors through the given user model
  current_user is assumed through admin screens

  Scenario: Saving a whatson post in whatson_posts#new associates the current_user as the author
    Given I am a logged in refinery user

    When I am on the new whatson post form
    And I fill in "Title" with "This is my whatson post"
    And I fill in "whatson_post_body" with "And I love it"
    And I press "Save"

    Then there should be 1 whatson post
    And the whatson post should belong to me