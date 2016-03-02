require 'rails_helper'

feature 'Index Page', type: :feature do
  context 'the User visits the index page' do
    before :each do
      visit root_path
    end

    scenario 'and should see "Hello World"' do
      expect(page).to have_text 'Hello World'
    end

    scenario 'and should see the menu bar' do
      expect(page).to have_css '#top-nav-bar'
    end

    scenario 'and should see the breadcrumbs with "Home"' do
      within '#breadcrumbs' do
        expect(page).to have_text 'Home'
      end
    end
  end
end
