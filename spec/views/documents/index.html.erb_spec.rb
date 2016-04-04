require 'rails_helper'

describe 'documents/index.html.erb', type: :view do
  it 'displays title "Documents"' do
    render
    expect(render).to have_selector 'h1'
    expect(render).to have_selector 'h1 > span.btn-group > a.btn'
    expect(render).to have_selector 'div#documents-table'
  end

  specify 'provides button to create new Document' do
    render
    expect(render).to have_link 'btn-new-document', href: new_document_path
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
