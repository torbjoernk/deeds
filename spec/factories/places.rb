FactoryGirl.define do
  factory :place_one, class: 'Place' do
    title 'A Place'
    notes 'A note'
  end

  factory :place_two, class: 'Place' do
    title 'Another Place'
    notes 'Some note on that'
  end
end
