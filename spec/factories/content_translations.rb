FactoryGirl.define do
  factory :content_translation do
    translation Faker::Lorem.paragraphs(5)
    language 'old_german'
    notes Faker::Lorem.paragraphs(2)
  end
end
