FactoryGirl.define do
  factory :person_relation, class: PersonRelation do
    relation_type PersonRelation::RELATION_TYPES[Faker::Number.between(0, PersonRelation::RELATION_TYPES.size - 1)]
    notes Faker::Lorem.paragraphs(2)
  end
end
