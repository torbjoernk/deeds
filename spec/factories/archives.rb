FactoryGirl.define do
  factory :archive do
    title Faker::Name.title
    abbr Faker::Lorem.characters(5)
    notes Faker::Lorem.paragraphs(3)
  end

  factory :archive_one, class: Archive do
    title 'Archive One'
    abbr 'Ar. 1'
    notes 'A text'
  end
end
