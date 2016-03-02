require 'rails_helper'

feature 'On the Index Page', type: :feature do
  context 'when the User visits the index page' do
    before :each do
      visit root_path
    end

    scenario 'then the User should see "Hello World"' do
      expect(page).to have_text 'Hello World'
    end

    scenario 'then the User should see the menu bar' do
      expect(page).to have_css '#top-nav-bar'
    end

    scenario 'then the User should see the breadcrumbs with "Home"' do
      expect(page).to have_breadcrumb 'Home'
    end
  end
end
