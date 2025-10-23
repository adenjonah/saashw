Given(/the following movies exist/) do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then(/I should see "(.*)" before "(.*)"/) do |e1, e2|
  # ensure that that e1 occurs before e2.
  # page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When(/I (un)?check the following ratings: (.*)/) do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %(I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}")
  end
end

# Domain-specific step definitions for better BDD practices

Given(/^I am on the RottenPotatoes home page$/) do
  visit movies_path
end

When(/^I go to the edit page for "([^"]*)"$/) do |movie_title|
  movie = Movie.find_by_title(movie_title)
  visit edit_movie_path(movie)
end

When(/^I am on the details page for "([^"]*)"$/) do |movie_title|
  movie = Movie.find_by_title(movie_title)
  visit movie_path(movie)
end

When(/^I follow "([^"]*)"$/) do |link_text|
  click_link link_text
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field_label, value|
  fill_in field_label, with: value
end

When(/^I press "([^"]*)"$/) do |button_text|
  click_button button_text
end

When(/^I select "([^"]*)" from "([^"]*)"$/) do |option, field|
  select option, from: field
end

Then(/^I should be on the Similar Movies page for "([^"]*)"$/) do |movie_title|
  movie = Movie.find_by_title(movie_title)
  expect(current_path).to eq similar_movie_path(movie)
end

Then(/^I should be on the home page$/) do
  expect(current_path).to eq movies_path
end

Then(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^I should not see "([^"]*)"$/) do |text|
  expect(page).to_not have_content(text)
end

Then('the director of {string} should be {string}') do |movie_title, director_name|
  movie = Movie.find_by_title(movie_title)
  expect(movie.director).to eq(director_name)
end

Then(/I should see all the movies/) do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %(I should see "#{movie.title}")
  end
end
