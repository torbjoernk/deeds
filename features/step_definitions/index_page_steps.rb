Given /^the User visits '\/'$/ do
  visit root_path
end

Then /^the User should see "([^"]*)"$/ do |arg|
  expect(page).to have_text arg
end
