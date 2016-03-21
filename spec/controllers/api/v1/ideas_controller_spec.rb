require 'rails_helper'

RSpec.describe Api::V1::IdeasController, type: :controller do
  it "will show index of ideas" do
    idea_1, idea_2 = create_list(:idea, 2)

    get :index, format: :json

    expect(response.status).to eq(200)

    ideas = JSON.parse(response.body)
    first_idea = ideas.first

    expect(first_idea['title']).to eq(idea_1.title)
    expect(first_idea['body']).to eq(idea_1.body)
    expect(first_idea['quality']).to eq(idea_1.quality)
  end
end
