require 'rails_helper'

describe 'content_translations/index.html.erb', type: :view do
  it 'displays title "Contents translation"' do
    render
    expect(render).to have_selector 'h1'
    expect(render).to have_selector 'h1 > span.btn-group > a.btn'
    expect(render).to have_table 'content-translations'
  end

  specify 'the table has four columns' do
    render
    expect(render).to have_selector 'table > thead > tr > th + th + th + th'
    expect(render).not_to have_selector 'table > thead > tr > th + th + th + th + th'
  end

  specify 'provides button to create new Content Translation' do
    render
    expect(render).to have_link 'btn-new-content-translation', href: new_content_translation_path
  end
end
