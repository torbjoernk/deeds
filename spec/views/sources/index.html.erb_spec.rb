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

  describe 'when filtered for associated Archive' do
    specify 'displays associated Archive', use_db: true do
      @archive = create :archive
      render

      expect(render).to have_text 'associated with Archive'
      expect(render).to have_text @archive.title
    end
  end
end
