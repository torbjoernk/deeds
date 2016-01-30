FactoryGirl.define do
  factory :archive_source_one, class: 'ArchiveSource' do
    association :archive, factory: :archive_one
    association :source, factory: :source_one
  end
end
