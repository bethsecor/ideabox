require 'rails_helper'

RSpec.feature "UserSeesIdeasOnPages", type: :feature do
  it "should see an existing idea on the page when visiting root", js: true do
    idea_1, idea_2 = create_list(:idea, 2)
    visit root_path

    expect(page).to have_content("Idea Box")

    within("#idea-#{idea_1.id}") do
      expect(page).to have_content(idea_1.title)
      expect(page).to have_content(idea_1.body)
      expect(page).to have_content(idea_1.quality)
    end

    within("#idea-#{idea_2.id}") do
      expect(page).to have_content(idea_2.title)
      expect(page).to have_content(idea_2.body)
      expect(page).to have_content(idea_2.quality)
    end
  end
end
