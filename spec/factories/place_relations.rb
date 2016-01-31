FactoryGirl.define do
  factory :place_relation_one_two, class: 'PlaceRelation' do
    association :place, factory: :place_one, strategy: :create
    association :related, factory: :place_two, strategy: :create
    notes 'note text'
  end

end
