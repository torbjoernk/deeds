FactoryGirl.define do
  factory :archive_source do
    association :archive, factory: :archive, strategy: :build
    association :source, factory: :source, strategy: :build
  end
end
