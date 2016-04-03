require 'rails_helper'

describe 'sources/index.html.erb', type: :view do
  it 'displays title "Sources"' do
    render
    expect(render).to have_selector 'h1'
    expect(render).to have_selector 'h1 > span.btn-group > a.btn'
    expect(render).to have_selector 'div#sources-table'
  end

  specify 'provides button to create new Source' do
    render
    expect(render).to have_link 'btn-new-source', href: new_source_path
  end

  describe 'when filtered for associated Collection' do
    specify 'displays associated Collection', use_db: true do
      collection = create :collection
      render

      expect(render).to have_text 'associated with Collection'
      expect(render).to have_text collection.title
    end
  end
end
