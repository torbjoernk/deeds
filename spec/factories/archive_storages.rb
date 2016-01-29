FactoryGirl.define do
  factory :archive_storage_one, class: 'ArchiveStorage' do
    association :archive, factory: :archive_one
    association :storage, factory: :storage_one
  end
end
