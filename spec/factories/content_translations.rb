FactoryGirl.define do
  factory :content_translation do
    translation Faker::Lorem.paragraphs(5)
    language Content::LANGUAGES[Faker::Number.between(0, Content::LANGUAGES.size - 1)]
    notes Faker::Lorem.paragraphs(2)
  end
end
