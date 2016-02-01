FactoryGirl.define do
  factory :content_one, class: 'Content' do
    content 'a latin text as the content'
    language 'latin'
    notes 'a note on the content'
  end
end
