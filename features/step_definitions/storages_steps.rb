Given /^a Storage exists$/ do
  @storage = create :storage
end


When /^the User visits '\/storages'$/ do
  visit storages_path
end

Then /^the User should see a table with storages$/ do
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


And(/^the User clicks on the 'Show' button of the first Storage$/) do
  find('table#storages > tbody > tr:first-child > td:last-child').
      click_on "btn-storage-show-details-#{@storage.id}"
end

Then /^the User should see the Storage's details$/ do
  expect(find('#storage-modal')).to have_text @storage.title
  expect(find('#storage-modal')).to have_text @storage.notes
end

