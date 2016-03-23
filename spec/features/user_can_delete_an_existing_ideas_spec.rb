require 'rails_helper'

RSpec.feature "UserCanDeleteAnExistingIdeas", type: :feature do
  it "can delete an idea by the click of a button", js: true do
    idea_1, idea_2 = create_list(:idea, 2)
    visit root_path

    within("#idea-#{idea_1.id}") do
      click_on "Delete"
    end

    expect(page).not_to have_content(idea_1.title)
    expect(page).not_to have_content(idea_1.body)

    within("#idea-#{idea_2.id}") do
      expect(page).to have_content(idea_2.title)
      expect(page).to have_content(idea_2.body)
      expect(page).to have_content(idea_2.quality)
    end
  end
end
