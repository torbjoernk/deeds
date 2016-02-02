FactoryGirl.define do
  factory :archive do
    title Faker::Name.title
    abbr Faker::Lorem.characters(5)
    notes Faker::Lorem.paragraphs(3)
  end
end
