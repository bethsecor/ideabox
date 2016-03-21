require 'rails_helper'

RSpec.describe Api::V1::IdeasController, type: :controller do
  it "will show index of ideas" do
    idea_1, idea_2 = create_list(:idea, 2)

    get :index, format: :json

    expect(response.status).to eq(200)

    ideas = JSON.parse(response.body)
    first_idea = ideas.first
    second_idea = ideas.last

    expect(first_idea['title']).to eq(idea_1.title)
    expect(first_idea['body']).to eq(idea_1.body)
    expect(first_idea['quality']).to eq(idea_1.quality)

    expect(second_idea['title']).to eq(idea_2.title)
    expect(second_idea['body']).to eq(idea_2.body)
    expect(second_idea['quality']).to eq(idea_2.quality)
  end

  it "will show show of an idea" do
    idea_1 = create(:idea)

    get :show, id: idea_1.id, format: :json

    expect(response.status).to eq(200)

    idea = JSON.parse(response.body)

    expect(idea['title']).to eq(idea_1.title)
    expect(idea['body']).to eq(idea_1.body)
    expect(idea['quality']).to eq(idea_1.quality)
  end

  it "can create an idea" do
    post :create, format: :json,
                  idea: {
                    title: "Super Awesome Idea",
                    body: "Cotton candy flavored toothpaste",
                    quality: "genius"
                  }

    expect(response.status).to eq 201

    api_idea = JSON.parse(response.body)

    expect(api_idea['title']).to eq "Super Awesome Idea"
    expect(api_idea['body']).to eq "Cotton candy flavored toothpaste"
    expect(api_idea['quality']).to eq "genius"
  end

  it "can update an idea" do
    idea_1 = create(:idea)
    put :update, id: idea_1.id, format: :json,
                  idea: {
                    title: "Super Awesome Idea",
                    body: "Cotton candy flavored toothpaste",
                    quality: "genius"
                  }
    expect(response.status).to eq 204

    idea_1_updated = Idea.find(idea_1.id)

    expect(idea_1_updated.title).to eq "Super Awesome Idea"
    expect(idea_1_updated.body).to eq "Cotton candy flavored toothpaste"
    expect(idea_1_updated.quality).to eq "genius"
  end

  it "can delete an idea" do
    idea_1 = create(:idea)
    delete :destroy, id: idea_1.id, format: :json

    expect(response.status).to eq 204
  end
end
