FactoryGirl.define do
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
