FactoryGirl.define do
  factory :mention do
    notes Faker::Lorem.paragraphs(2)
  end
end
