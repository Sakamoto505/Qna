require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
} do

  given(:user) {create(:user)}
  given!(:question) {create(:question)}
  given(:gist_url) {'https://gist.github.com/Sakamoto505/590f834036d3ecf6cfafa425b67b1949'}

  scenario 'User adds link when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Body', with: '1212 1212'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Answer'

    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url
    end
  end

end