FactoryGirl.define do
  factory :role do
    title Faker::Name.title
    referring Role::REFERS_TO[Faker::Number.between(0, Role::REFERS_TO.size - 1)]
    notes Faker::Lorem.paragraphs(2)
  end
end
