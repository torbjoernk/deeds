FactoryGirl.define do
  factory :collection_document do
    association :collection, factory: :collection, strategy: :build
    association :document, factory: :document, strategy: :build
  end
end
