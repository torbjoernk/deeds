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

  specify 'provides button to create new Archive' do
    render
    expect(render).to have_link 'btn-new-archive', href: new_archive_path
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
