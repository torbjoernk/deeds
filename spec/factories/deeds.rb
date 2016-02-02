FactoryGirl.define do
  factory :deed do
    title Faker::Name.title
    year 1166
    month 2
    day 20
    description Faker::Lorem.sentences(2)
    notes Faker::Lorem.paragraphs(2)
  end

  factory :deed_one, class: 'Deed' do
    title 'A Deed'
    year 1
    month 2
    day 3
    description 'a description'
    notes 'some notes'
  end
end
