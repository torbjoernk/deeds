FactoryGirl.define do
  factory :archive_one, class: Archive do
    title 'Archive One'
    abbr 'Ar. 1'
    notes 'A text'
  end

  factory :archive_two, class: Archive do
    title 'Archive Two'
    abbr 'Ar. 2'
    notes 'Another text'
  end
end
