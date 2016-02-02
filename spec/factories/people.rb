FactoryGirl.define do
  factory :person do
    name Faker::Name.name
    gender Person::GENDERS[Faker::Number.between(0, Person::GENDERS.size - 1)]
    notes Faker::Lorem.paragraphs(2)
  end

  factory :person_one, class: Person do
    name 'Test Person Male'
    gender 'male'
    notes 'Test Note'
  end

  factory :person_two, class: Person do
    name 'Test Person Female'
    gender 'female'
    notes 'Test Note text'
  end
end
