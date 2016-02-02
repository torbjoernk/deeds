FactoryGirl.define do
  factory :deed_format do
    material DeedFormat::MATERIALS[Faker::Number.between(0, DeedFormat::MATERIALS.size - 1)]
    width Faker::Number.positive
    height Faker::Number.positive
  end

  factory :deed_format_one, class: 'DeedFormat' do
    material 'parchment'
    width 1.5
    height 1.5
  end
end
