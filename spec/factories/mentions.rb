FactoryGirl.define do
  factory :mention_per1_pla1_rol1, class: 'Mention' do
    association :person, factory: :person_one, strategy: :create
    association :place, factory: :place_one, strategy: :create
    association :role, factory: :role_one, strategy: :create
    notes 'a note'
  end

  factory :mention_per2_pla2_rol1, class: 'Mention' do
    association :person, factory: :person_two, strategy: :create
    association :place, factory: :place_two, strategy: :create
    association :role, factory: :role_one, strategy: :create
    notes 'a note'
  end
end
