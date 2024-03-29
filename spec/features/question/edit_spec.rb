# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit question', "
  In order to correct mistake in question
  As an authenticated user
  I'd like to be able to edit question
" do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  describe 'Authenticated user', js: true do
    given(:another_question) { create(:question) }

    background do
      sign_in(user)
    end

    scenario 'edits his question' do
      visit question_path(question)
      within all('.question').last do
        click_on 'Edit question'
        fill_in 'Title', with: 'Test question'
        fill_in 'Body', with: 'text text text?'
        click_on 'Save'
      end
      expect(page).to_not have_content question.title
      expect(page).to_not have_content question.body
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'text text text?'
    end

    scenario 'edits question with errors' do
      visit question_path(question)
      within all('.question').last do
        click_on 'Edit question'
        fill_in 'Title', with: ''
        click_on 'Save'
      end

      expect(page).to have_content "Title can't be blank"
    end
    scenario 'edits not his question' do
      visit question_path(another_question)
      expect(page).to have_no_link('Edit question')
    end
  end
  context 'Unauthenticated user' do
    scenario 'edits question' do
      visit question_path(question)
      expect(page).to have_no_link('Edit question')
    end
  end
end
