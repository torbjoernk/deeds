FactoryGirl.define do
  factory :deed do
    title Faker::Name.title
    year Faker::Number.between(0, Date.today().year)
    month Faker::Number.between(1, 12)
    day Faker::Number.between(1, 31)
    description Faker::Lorem.sentences(2)
    notes Faker::Lorem.paragraphs(2)
  end
end
