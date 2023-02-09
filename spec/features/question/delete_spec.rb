# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete question', '
  I would like to be able to delete a
  question as an (un)authorized user
' do
  given(:current_user) { create(:user) }
  given(:question_author) { create(:user) }
  given(:question) { create(:question, author: current_user) }

  describe 'Authorized user' do
    background do
      sign_in(current_user)
    end

    scenario 'Deletes his question' do
      visit question_path(question)

      click_on 'Delete'

      expect(page).to have_content 'Question was successfully deleted'
      expect(page).to_not have_content 'Question_title'
      expect(page).to_not have_content 'Question_body'
    end
  end

  given(:another_question) { create(:question, author: question_author) }

  scenario 'trying to delete not your question' do
    sign_in(current_user)
    visit question_path(another_question)

    expect(page).to have_no_link 'Delete'
  end

  describe 'Unauthorized user' do
    scenario 'Trying to delete' do
      visit question_path(question)

      expect(page).to have_no_link 'Delete'
    end
  end
end
