FactoryGirl.define do
  factory :place_relation do
    relation_type PlaceRelation::RELATION_TYPES[Faker::Number.between(0, PlaceRelation::RELATION_TYPES.size - 1)]
    notes Faker::Lorem.paragraphs(2)
  end
end
