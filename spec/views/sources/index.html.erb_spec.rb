require 'rails_helper'

describe 'sources/index.html.erb', type: :view do
  it 'displays title "Sources"' do
    render
    expect(render).to have_selector 'h1'
    expect(render).to have_selector 'h1 > span.btn-group > a.btn'
    expect(render).to have_table 'sources'
  end

  specify 'the table has four columns' do
    render
    expect(render).to have_selector 'table > thead > tr > th + th + th + th'
    expect(render).not_to have_selector 'table > thead > tr > th + th + th + th + th'
  end

  specify 'provides button to create new Source' do
    render
    expect(render).to have_link 'btn-new-source', href: new_source_path
  end
end
