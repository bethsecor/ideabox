require 'rails_helper'

RSpec.feature "UserCanDecreaseQualityOfIdeas", type: :feature do
  it "should decrease quality level when clicking thumbs up", js: true do
    idea = create(:idea, quality: 2)
    visit root_path

    within("#idea-#{idea.id}") do
      expect(page).to have_content("Quality: genius")
      click_on "thumbs down"
      expect(page).to have_content("Quality: plausible")
      click_on "thumbs down"
      expect(page).to have_content("Quality: swill")
      click_on "thumbs down"
      expect(page).to have_content("Quality: swill")
    end
  end
end
