require 'rails_helper'

shared_examples 'an IconicModel', type: :model_concern do |model|
  specify 'has model-specific ::ICON' do
    expect(model::ICON).to be_a String
  end
end
