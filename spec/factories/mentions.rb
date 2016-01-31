FactoryGirl.define do
  factory :mention_per1_pla1_rol1, class: 'Mention' do
    association :person, factory: :person_one, strategy: :create
    association :place, factory: :place_one, strategy: :create
    association :role, factory: :role_one, strategy: :create
    notes 'a note'
  end
end
