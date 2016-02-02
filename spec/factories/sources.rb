FactoryGirl.define do
  factory :source do
    title Faker::Name.title
    source_type 'original'
    notes Faker::Lorem.paragraphs(2)
  end
end
