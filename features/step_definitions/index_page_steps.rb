Given /^the User visits '\/'$/ do
  visit root_path
end

Then /^the User should see "([^"]*)"$/ do |arg|
  expect(page).to have_text arg
end

Then(/^the User should see the main menu bar at the top$/) do
  expect(page).to have_css '#top-nav-bar'
end

Then(/^the User should see the breadcrumbs with "([^"]*)"$/) do |arg|
  expect(page).to have_css '#breadcrumbs'
  within '#breadcrumbs' do
    expect(page).to have_text 'Home'
  end
end
