require 'rails_helper'

RSpec.feature "UserCanEnterLongBodyThatWillTruncateOnPages", type: :feature do
  it "can create an idea with long body that will be truncated", js: true do
    visit root_path

    fill_in "Title", with: "Snow days"
    fill_in "Body", with: "let it snow let it snow let it snow let it " \
    "snow let it snow let it snow let it snow let it snow let it snow let it snow"
    click_on "Save"

    within(find('.idea', match: :first)) do
      expect(page).to have_content("Snow days")
      expect(page).to have_content("let it snow let it snow let it snow let it " \
      "snow let it snow let it snow let it snow let it snow let")
      expect(page).to have_content("Quality: swill")
    end
  end
end
