FactoryGirl.define do
  factory :storage do
    title Faker::Name.title
    notes Faker::Lorem.paragraphs(2)
  end

  factory :storage_one, class: Storage do
    title 'Storage Title'
    notes 'A text'
  end
end
