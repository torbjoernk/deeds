FactoryGirl.define do
  factory :collection_storage do
    association :collection, factory: :collection, strategy: :build
    association :storage, factory: :storage, strategy: :build
  end
end
