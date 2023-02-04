require 'rails_helper'

feature 'Show question', %(
  The user wants to see
  a list of all questions
  you can watch without registration,
  as well as with registration
) do
  given!(:question) { create(:question) }

  background do
    visit questions_path
  end

  scenario 'Questions for an unregistered user' do
    expect(page).to have_content question.title
  end

  given(:user) { create(:user) }

  scenario 'Questions for a registered user' do
    sign_in(user)
    expect(page).to have_content question.title
  end
end
