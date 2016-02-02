FactoryGirl.define do
  factory :place do
    title Faker::Name.title
    notes Faker::Lorem.paragraphs(2)
  end

  factory :place_one, class: 'Place' do
    title 'A Place'
    notes 'A note'
  end

  factory :place_two, class: 'Place' do
    title 'Another Place'
    notes 'Some note on that'
  end
end
