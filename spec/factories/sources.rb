FactoryGirl.define do
  factory :source_one, class: 'Source' do
    title 'A Source'
    source_type 'original'
    notes 'notes text'
  end
end
