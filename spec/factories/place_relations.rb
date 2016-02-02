FactoryGirl.define do
  factory :place_relation do
    relation_type PlaceRelation::RELATION_TYPES[Faker::Number.between(0, PlaceRelation::RELATION_TYPES.size - 1)]
    notes Faker::Lorem.paragraphs(2)
  end

  factory :place_relation_one_two, class: 'PlaceRelation' do
    association :place, factory: :place_one, strategy: :create
    association :related, factory: :place_two, strategy: :create
    notes 'note text'
  end
end
