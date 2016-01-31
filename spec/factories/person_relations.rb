FactoryGirl.define do
  factory :person_relation_one_two, class: PersonRelation do
    association :person, factory: :person_one, strategy: :create
    association :related, factory: :person_two, strategy: :create
    notes 'note text'
  end
end
