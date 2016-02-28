require 'rails_helper'

describe 'archives/index.html.erb', type: :view do
  it 'displays title "Archives"' do
    render
    expect(render).to have_selector 'h1'
    expect(render).to have_selector 'h1 > span.btn-group > a.btn'
    expect(render).to have_table 'archives'
  end

  specify 'the table has five columns' do
    render
    expect(render).to have_selector 'table > thead > tr > th + th + th + th + th'
    expect(render).not_to have_selector 'table > thead > tr > th + th + th + th + th + th'
  end
end
