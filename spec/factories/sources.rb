FactoryGirl.define do
  factory :source do
    title Faker::Name.title
    source_type 'original'
    notes Faker::Lorem.paragraphs(2)
  end

  factory :source_one, class: 'Source' do
    title 'A Source'
    source_type 'original'
    notes 'notes text'
  end
end
