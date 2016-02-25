require 'rails_helper'

describe 'storages/index.html.erb', type: :view do
  it 'displays title "Storages"' do
    render
    expect(render).to have_selector 'h1'
    expect(render).to have_selector 'h1 > span.btn-group > a.btn'
    expect(render).to have_table 'storages'
  end

  specify 'the table has three columns' do
    render
    expect(render).to have_selector 'table > thead > tr > th + th + th'
    expect(render).not_to have_selector 'table > thead > tr > th + th + th + th'
  end
end
