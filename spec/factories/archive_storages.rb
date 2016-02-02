FactoryGirl.define do
  factory :archive_storage do
    association :archive, factory: :archive, strategy: :build
    association :storage, factory: :storage, strategy: :build
  end
end
