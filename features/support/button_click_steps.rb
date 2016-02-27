When /^clicks on "([^"]*)"$/ do |arg|
  click_on arg
end

When /^the User clicks on the "([^"]*)" button$/ do |arg|
  click_on "btn-#{arg.gsub(' ', '-').downcase}"
end
