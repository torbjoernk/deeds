FactoryGirl.define do
  factory :source do
    title Faker::Name.title
    source_type Source::SOURCE_TYPES[Faker::Number.between(0, Source::SOURCE_TYPES.size - 1)]
    notes Faker::Lorem.paragraphs(2)
  end
end
