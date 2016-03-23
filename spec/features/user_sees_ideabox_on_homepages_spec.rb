require 'rails_helper'

RSpec.feature "UserSeesIdeaboxOnHomepages", type: :feature do
  it "should see Idea Box on the page when visiting root" do
    visit root_path

    expect(page).to have_content("Idea Box")
  end
end
