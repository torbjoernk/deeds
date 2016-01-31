FactoryGirl.define do
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
