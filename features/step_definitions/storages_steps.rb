Given /^a Storage exists$/ do
  @storage = create :storage
end

Given /^the User visits '\/storages'$/ do
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


When /^the User clicks on the "([^"]*)" button of the first Storage$/ do |arg|
  within "#storage-row-#{@storage.id}" do
    click_on "btn-storage-#{arg.downcase}-#{@storage.id}"
  end
end

Then /^the User should see the Storage's details$/ do
  expect(find('#storage-modal')).to have_text @storage.title
  expect(find('#storage-modal')).to have_text @storage.notes
end


When /^changes the Storage's title$/ do
  @new_title = Faker::Name.title
  fill_in 'Title', with: @new_title
end

When /^clicks on "([^"]*)"$/ do |arg|
  click_on arg
end

Then /^the Storage's title should be changed to the new value$/ do
  within "#storage-row-#{@storage.id}" do
    expect(page).to have_text @new_title
  end
end


When /^the User clicks on the 'Delete' button of the first Storage and accepts the confirmation$/ do
  within "#storage-row-#{@storage.id}" do
    accept_confirm do
      click_on "btn-storage-delete-#{@storage.id}"
    end
  end
end

Then /^the Storage should get deleted$/ do
  expect(page).not_to have_selector "#storage-row-#{@storage.id}"
end


When /^the User clicks on the 'Delete' button of the first Storage and dismisses the confirmation$/ do
  within "#storage-row-#{@storage.id}" do
    dismiss_confirm do
      click_on "btn-storage-delete-#{@storage.id}"
    end
  end
end

Then /^the Storage should be kept$/ do
  expect(page).to have_selector "#storage-row-#{@storage.id}"
end


When /^the User clicks on the "([^"]*)" button$/ do |arg|
  click_on "btn-#{arg.downcase}-storage"
end

When /^enters the new Storage's title$/ do
  @new_storage = build(:storage, title: Faker::Name.title)
  expect(@new_storage.title).not_to eq @storage.title
  within "#storage-modal" do
    fill_in 'Title', with: @new_storage.title
  end
end

Then /^a new Storage with given title should be created$/ do
  expect(page).to have_text @new_storage.title
end
