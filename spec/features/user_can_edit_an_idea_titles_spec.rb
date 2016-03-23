require 'rails_helper'

RSpec.feature "UserCanEditAnIdeaTitles", type: :feature do
  it "should inline edit the title for an idea", js: true do
    idea_1, idea_2 = create_list(:idea, 2)

    visit root_path

    within("#idea-#{idea_1.id}") do
      title = find("#edit-title")
      title.click
      title.set("AWESOME IDEA")
    end

    find("h1").click

    within("#idea-#{idea_1.id}") do
      expect(page).to have_content "AWESOME IDEA"
      expect(page).to have_content idea_1.body
      expect(page).to have_content idea_1.quality
    end
  end
end
