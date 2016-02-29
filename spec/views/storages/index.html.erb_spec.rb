require 'rails_helper'

describe 'storages/index.html.erb', type: :view do
  it 'displays title "Storages"' do
    render
    expect(render).to have_selector 'h1'
    expect(render).to have_selector 'h1 > span.btn-group > a.btn'
    expect(render).to have_table 'storages'
  end

  specify 'the table has four columns' do
    render
    expect(render).to have_selector 'table > thead > tr > th + th + th + th'
    expect(render).not_to have_selector 'table > thead > tr > th + th + th + th + th'
  end

  specify 'provides button to create new Storage' do
    render
    expect(render).to have_link 'btn-new-storage', href: new_storage_path
  end

  describe 'when filtered for associated Archive' do
    specify 'displays associated Archive' do
      @archive = create :archive
      render

      expect(render).to have_text 'associated with Archive'
      expect(render).to have_text @archive.title
    end
  end
end
