FactoryGirl.define do
  factory :content do
    content Faker::Lorem.paragraphs(5)
    language 'latin'
    notes Faker::Lorem.paragraphs(2)
  end
end
