FactoryGirl.define do
  factory :storage_one, class: Storage do
    title 'Storage Title'
    notes 'A text'
  end

  factory :storage_two, class: Storage do
    title 'Another Storage Title'
    notes 'A textual note'
  end
end
