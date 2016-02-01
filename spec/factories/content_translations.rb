FactoryGirl.define do
  factory :content_translation_one, class: 'ContentTranslation' do
    association :content, factory: :content_one, strategy: :create
    translation 'a translation'
    language 'old_german'
    notes 'a note on the translation'
  end
end
