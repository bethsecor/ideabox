require 'rails_helper'

RSpec.feature "UserCanIncreaseQualityOfIdeas", type: :feature do
  it "should increase quality level when clicking thumbs up", js: true do
    idea = create(:idea)
    visit root_path

    within("#idea-#{idea.id}") do
      expect(page).to have_content("Quality: swill")
      click_on "thumbs up"
      expect(page).to have_content("Quality: plausible")
      click_on "thumbs up"
      expect(page).to have_content("Quality: genius")
      click_on "thumbs up"
      expect(page).to have_content("Quality: genius")
    end
  end
end
