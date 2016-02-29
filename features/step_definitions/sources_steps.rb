Given /^a Source exists$/ do
  @source = create :source
end

Given /^the User visits '\/sources'$/ do
  visit sources_path
end


When /^enters the new Source's title$/ do
  @new_source = build(:source, title: Faker::Name.title)
  expect(@new_source.title).not_to eq @source.title
  within '#source-modal' do
    fill_in 'Title', with: @new_source.title
  end
end

When /^enters the new Source's type$/ do
  within '#source-modal' do
    fill_in 'Source type', with: @new_source.source_type
  end
end

When /^the User clicks on the "([^"]*)" button of the first Source$/ do |arg|
  within "#source-row-#{@source.id}" do
    click_on "btn-source-#{arg.downcase}-#{@source.id}"
  end
end

When /^changes the Source's title$/ do
  @new_title = Faker::Name.title
  fill_in 'Title', with: @new_title
end

When /^the User clicks on the 'Delete' button of the first Source and accepts the confirmation$/ do
  within "#source-row-#{@source.id}" do
    accept_confirm do
      click_on "btn-source-delete-#{@source.id}"
    end
  end
end

When /^the User clicks on the 'Delete' button of the first Source and dismisses the confirmation$/ do
  within "#source-row-#{@source.id}" do
    dismiss_confirm do
      click_on "btn-source-delete-#{@source.id}"
    end
  end
end


Then /^the User should see a table with sources$/ do
  expect(page).to have_table 'sources'

  within_table 'sources' do
    # exactly three columns
    expect(page).to have_selector 'thead > tr > th + th + th + th + th'
    expect(page).not_to have_selector 'thead > tr > th + th + th + th + th + th'

    within 'thead > tr > th:first-child' do
      expect(page).to have_text 'Title'
    end
    within 'thead > tr > th:nth-child(2)' do
      expect(page).to have_text 'Source Type'
    end
    within 'thead > tr > th:nth-child(3)' do
      expect(page).to have_text 'Notes'
    end
    within 'thead > tr > th:last-child' do
      expect(page).to have_text 'Actions'
    end
  end
end

Then /^a new Source with given title and type should be created$/ do
  expect(page).to have_text @new_source.title
  expect(page).to have_text @new_source.source_type
end

Then /^the User should see the Source's details$/ do
  expect(find('#source-modal')).to have_text @source.title
  expect(find('#source-modal')).to have_text @source.source_type
  expect(find('#source-modal')).to have_text @source.notes
end

Then /^the Source's title should be changed to the new value$/ do
  within "#source-row-#{@source.id}" do
    expect(page).to have_text @new_title
  end
end

Then /^the Source should get deleted$/ do
  expect(page).not_to have_selector "#source-row-#{@source.id}"
end

Then /^the Source should be kept$/ do
  expect(page).to have_selector "#source-row-#{@source.id}"
end
