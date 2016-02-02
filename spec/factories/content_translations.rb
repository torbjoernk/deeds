FactoryGirl.define do
  factory :content_translation do
    translation Faker::Lorem.paragraphs(5)
    language 'old_german'
    notes Faker::Lorem.paragraphs(2)
  end

  factory :content_translation_one, class: 'ContentTranslation' do
    association :content, factory: :content_one, strategy: :create
    translation 'a translation'
    language 'old_german'
    notes 'a note on the translation'
  end
end
