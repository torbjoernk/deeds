FactoryGirl.define do
  factory :collection do
    title Faker::Name.title
    abbr Faker::Lorem.characters(5)
    notes Faker::Lorem.paragraphs(3)
  end
end
