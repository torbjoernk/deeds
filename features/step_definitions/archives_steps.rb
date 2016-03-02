Given /^an Archive exists$/ do
  @archive = create :archive
end

Given /^the User visits '\/archives'$/ do
  visit archives_path
end


When /^enters the new Archive's title$/ do
  @new_archive = build(:archive, title: Faker::Name.title, abbr: Faker::Lorem.characters(5))
  within '#archive-modal' do
    fill_in 'Title', with: @new_archive.title
  end
end

When /^the User clicks on the 'Show' button of the first Archive$/ do
  find(:css, "#btn-archive-show-#{@archive.id}").click
end

When /^the User changes the Archive's title$/ do
  @new_title = Faker::Name.title
  fill_in 'Title', with: @new_title
end

When /^the User clicks on the 'Edit' button of the first Archive$/ do
  find(:css, "#btn-archive-edit-#{@archive.id}").click
end

When /^the User clicks on the 'Delete' button of the first Archive and accepts the confirmation$/ do
  accept_confirm do
    find(:css, "#btn-archive-delete-#{@archive.id}").click
  end
end

When /^the User clicks on the 'Delete' button of the first Archive and dismisses the confirmation$/ do
  dismiss_confirm do
    find(:css, "#btn-archive-delete-#{@archive.id}").click
  end
end


Then /^the User should see a table with archives$/ do
  expect(page).to have_table 'archives'

  within_table 'archives' do
    # exactly four columns
    expect(page).to have_selector 'thead > tr > th + th + th + th + th'
    expect(page).not_to have_selector 'thead > tr > th + th + th + th + th + th'

    within 'thead > tr > th:first-child' do
      expect(page).to have_text 'Title'
    end
    within 'thead > tr > th:nth-child(2)' do
      expect(page).to have_text 'Abbreviation'
    end
    within 'thead > tr > th:nth-child(3)' do
      expect(page).to have_text 'Notes'
    end
    within 'thead > tr > th:last-child' do
      expect(page).to have_text 'Actions'
    end
  end
end

Then /^a new Archive with given title should be created$/ do
  expect(page).to have_text @new_archive.title
end

Then /^the User should see the Archives's details$/ do
  within '#archive-modal' do
    expect(page).to have_text @archive.title
    expect(page).to have_text @archive.notes
  end
end

Then /^the Archive's title should be changed to the new value$/ do
  within "#archive-row-#{@archive.id}" do
    expect(page).to have_text @new_title
  end
end

Then /^the Archive should get deleted$/ do
  expect(page).not_to have_selector "#archive-row-#{@archive.id}"
end

Then /^the Archive should be kept$/ do
  expect(page).to have_selector "#archive-row-#{@archive.id}"
end
