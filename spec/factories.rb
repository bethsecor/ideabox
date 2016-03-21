FactoryGirl.define do
  factory :idea do
    sequence(:title) { |n| "title_#{n}"}
    sequence(:body) { |n| "body_#{n}"}
    quality 0
  end
end
