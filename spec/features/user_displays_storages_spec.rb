feature 'User interacts with Storages', type: :feature do
  context 'when navigating to the index' do
    scenario 'the User should see a table with the storages' do
      visit storages_path

      expect(page).to have_table 'storages'
      within_table 'storages' do
        # exactly three columns
        expect(page).to have_selector 'thead > tr > th + th + th'
        expect(page).not_to have_selector 'thead > tr > th + th + th + th'

        within 'thead > tr > th:first-child' do
          expect(page).to have_text 'Title'
        end
        within 'thead > tr > th:nth-child(2)' do
          expect(page).to have_text 'Notes'
        end
        within 'thead > tr > th:last-child' do
          expect(page).to have_text 'Actions'
        end
      end
    end
  end

  context 'when displaying the details of a Storage' do
    scenario 'the User should see Storage details by clicking on the "Show" button', js: true do
      storage = create :storage

      visit storages_path

      expect(page).to have_selector 'table#storages > tbody > tr:first-child > td + td + td'

      within_table 'storages' do
        within 'tbody > tr:first-child' do
          expect(page).to have_text storage.title
          expect(page).to have_text storage.notes
        end
      end

      find('table#storages > tbody > tr:first-child > td:last-child').
          click_on "btn-storage-show-details-#{storage.id}"

      expect(find('#storage-modal')).to have_text storage.title
      expect(find('#storage-modal')).to have_text storage.notes
    end
  end
end
