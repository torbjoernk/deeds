require 'rails_helper'

describe 'contents/index.html.erb', type: :view do
  it 'displays title "Contents"' do
    render
    expect(render).to have_selector 'h1'
    expect(render).to have_selector 'h1 > span.btn-group > a.btn'
    expect(render).to have_selector 'div#contents-table'
  end

  specify 'provides button to create new Content' do
    render
    expect(render).to have_link 'btn-new-content', href: new_content_path
  end
end
