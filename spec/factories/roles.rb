FactoryGirl.define do
  factory :role do
    title Faker::Name.title
    referring Role::REFERS_TO[Faker::Number.between(0, Role::REFERS_TO.size - 1)]
    notes Faker::Lorem.paragraphs(2)
  end

  factory :role_one, class: 'Role' do
    title 'A Role for a Person'
    referring 'person'
    notes "a note on the person's role"
  end

  factory :role_two, class: 'Role' do
    title 'A Role for a Place'
    referring 'place'
    notes "a note on the place's role"
  end
end
