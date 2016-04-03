require 'rails_helper'

describe 'collections/index.html.erb', type: :view do
  it 'displays title "Collections"' do
    render
    expect(render).to have_selector 'h1'
    expect(render).to have_selector 'h1 > span.btn-group > a.btn'
    expect(render).to have_selector 'div#collections-table'
  end

  specify 'provides button to create new Collection' do
    render
    expect(render).to have_link 'btn-new-collection', href: new_collection_path
  end

  describe 'when filtered for associated Storage' do
    specify 'displays associated Storage', use_db: true do
      @storage = create :storage
      render

      expect(render).to have_text 'associated with Storage'
      expect(render).to have_text @storage.title
    end
  end
end
