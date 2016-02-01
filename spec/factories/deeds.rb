FactoryGirl.define do
  factory :deed_one, class: 'Deed' do
    title 'A Deed'
    year 1
    month 2
    day 3
    description 'a description'
    notes 'some notes'
  end
end
