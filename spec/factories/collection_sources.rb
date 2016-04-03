FactoryGirl.define do
  factory :collection_source do
    association :collection, factory: :collection, strategy: :build
    association :source, factory: :source, strategy: :build
  end
end
