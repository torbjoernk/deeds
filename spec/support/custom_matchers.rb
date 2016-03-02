require 'rspec/expectations'

RSpec::Matchers.define :have_breadcrumb do |expected|
  match do |actual|
    within '#breadcrumbs' do
      expect(actual).to have_text expected
    end
  end
end
