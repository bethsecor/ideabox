require 'rails_helper'

RSpec.describe Idea, type: :model do
  it "can create an idea  without specifiying quality" do
    idea = Idea.create(title: "Awesome Idea", body: "amazing!!!!")
    expect(idea.quality).to eq("swill")
  end
end
