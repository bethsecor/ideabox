require 'rails_helper'

RSpec.feature "UserCanEditAnIdeaBody", type: :feature do
  it "should inline edit the title for an idea", js: true do
    idea_1, idea_2 = create_list(:idea, 2)

    visit root_path

    within("#idea-#{idea_1.id}") do
      body = find("#edit-body")
      body.click
      body.set("Super amazing idea, this is going to be big!")
    end

    find("h1").click

    within("#idea-#{idea_1.id}") do
      expect(page).to have_content idea_1.title
      expect(page).to have_content "Super amazing idea, this is going to be big!"
      expect(page).to have_content idea_1.quality
    end
  end
end
