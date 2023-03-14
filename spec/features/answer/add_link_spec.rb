# frozen_string_literal: true

require 'rails_helper'

feature 'User can add links to answer', "
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
" do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:link) { create(:link, linkable: question) }

  scenario 'User adds link when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Body', with: '1212 1212'

    fill_in 'Link name', with: link.name
    fill_in 'Url', with: link.url
    click_on 'Answer'

    within '.answers' do
      expect(page).to have_link link.name
    end
  end

  scenario 'User adds links when add answer with errors', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: '1212 1212'
    fill_in 'Url', with: 'google.ru'

    click_on 'Answer'
    expect(page).to have_content 'Links url is invalid'
    expect(page).to have_content "Links name can't be blank"
  end
end
