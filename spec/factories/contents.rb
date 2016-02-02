FactoryGirl.define do
  factory :content do
    content Faker::Lorem.paragraphs(5)
    language 'latin'
    notes Faker::Lorem.paragraphs(2)
  end

  factory :content_one, class: 'Content' do
    content 'a latin text as the content'
    language 'latin'
    notes 'a note on the content'
  end
end
