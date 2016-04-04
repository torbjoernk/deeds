FactoryGirl.define do
  factory :document do
    title Faker::Name.title
    document_type Document::DOCUMENT_TYPES[Faker::Number.between(0, Document::DOCUMENT_TYPES.size - 1)]
    notes Faker::Lorem.paragraphs(2)
  end
end
