FactoryGirl.define do
  factory :person do
    name Faker::Name.name
    gender Person::GENDERS[Faker::Number.between(0, Person::GENDERS.size - 1)]
    notes Faker::Lorem.paragraphs(2)
  end
end
