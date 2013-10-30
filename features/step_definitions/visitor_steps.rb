Given /^I am viewing '(.+)'$/ do |url|
  visit(url)
end

Given /^I fill in '(.*)' for '(.*)'$/ do |value, field|
  fill_in(field, :with => value)
end

When /^I press '(.*)'$/ do |name|
  click_button(name)
end

Then /^I should see '(.*)'$/ do |text|
  page.should have_content(/#{text}/m)
end