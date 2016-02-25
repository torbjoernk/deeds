feature 'User enters page', type: :feature do
  scenario 'they see "Hello World"' do
    visit root_path

    expect(page).to have_text 'Hello World'
  end
end
