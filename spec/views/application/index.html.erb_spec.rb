require 'rails_helper'

describe 'application/index.html.erb' do
  context 'when rendered' do
    it 'displays text "Hello World"' do
      render
      expect(render).to have_content 'Hello World'
    end
  end
end
