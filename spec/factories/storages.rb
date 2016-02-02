FactoryGirl.define do
  factory :storage do
    title Faker::Name.title
    notes Faker::Lorem.paragraphs(2)
  end
end
