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

  it "should filter ideas on the page when filling in search box with middle of title", js: true do
    idea_1 = create(:idea, title: "Doctor Who Marathon")
    idea_2 = create(:idea, title: "Doctors Without Borders")
    idea_3 = create(:idea, title: "Hovercrafts")

    visit root_path

    fill_in "Search", with: "who"

    expect(page).to_not have_content("Hovercrafts")
    expect(page).to_not have_content("Doctors Without Borders")

    expect(page).to have_content("Doctor Who Marathon")
  end

  it "should filter ideas on the page when filling in search box for body", js: true do
    idea_1 = create(:idea, body: "Musicals in the theatre next door")
    idea_2 = create(:idea, body: "Jazz Music on the patio")
    idea_3 = create(:idea, body: "Hovercrafts")

    visit root_path

    fill_in "Search", with: "music"

    expect(page).to_not have_content("Hovercrafts")

    expect(page).to have_content("Musicals in the theatre next door")
    expect(page).to have_content("Jazz Music on the patio")
  end
end
