FactoryGirl.define do
  factory :place do
    title Faker::Name.title
    notes Faker::Lorem.paragraphs(2)
  end
end
