require 'rails_helper'

describe 'application/index.html.erb', type: :view do
  it 'displays text "Hello World"' do
    render
    expect(render).to have_content 'Hello World'
  end
end
