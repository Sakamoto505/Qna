# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit answer', "
  In order to correct mistake in answer
  As an authenticated user
  I'd like to be able to edit answer
" do
  context 'Unauthenticated user' do
    scenario 'edits answer' do
      visit question_path(question)
      expect(page).to have_no_link('Edit answer')
    end
  end

  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, author: user, question: question) }

  describe 'Authenticated user', js: true do
    scenario 'edits his answer' do
      sign_in(user)
      visit question_path(question)
      click_on 'Edit answer'

      within '.answers' do
        fill_in 'Your answer', with: 'edited answer'
        click_on 'Save'
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector "#edit-answer-#{answer.id} textarea"
      end
    end

    scenario 'can attach file when editing' do
      sign_in(user)
      visit question_path(question)
      click_on 'Edit answer'
      within '.answers' do
        attach_file 'Files', %W[#{Rails.root}/spec/rails_helper.rb #{Rails.root}/spec/spec_helper.rb]
        click_on 'Save'
      end
    end

    scenario 'edits answer with errors' do
      sign_in(user)
      visit question_path(question)
      click_on 'Edit answer'

      within '.answers' do
        fill_in 'Your answer', with: ''
        click_on 'Save'
      end
      expect(page).to have_content "Body can't be blank"
    end
  end
end
