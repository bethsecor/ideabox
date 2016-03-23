require 'rails_helper'

RSpec.feature "UserCanFilterIdeasWithSearchBoxes", type: :feature do
  it "should filter ideas on the page when filling in search box", js: true do
    idea_1 = create(:idea, title: "Doctor Who Marathon")
    idea_2 = create(:idea, title: "Doctors Without Borders")
    idea_3 = create(:idea, title: "Hovercrafts")

    visit root_path

    fill_in "Search", with: "doctor"

    expect(page).to_not have_content("Hovercrafts")

    expect(page).to have_content("Doctor Who Marathon")
    expect(page).to have_content("Doctors Without Borders")
  end
end
