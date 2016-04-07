FactoryGirl.define do
  factory :mention_entry do
    notes Faker::Lorem.paragraphs(2)
  end
end
