require 'rails_helper'

feature 'User can choose the best answer to the question', "
  In order to distinguish the answer from the rest
  As an authenticated user
  I'd like to be able choose the best an answer
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:answer) { create(:answer, author: user, question: question) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end
  end

  scenario 'select the best answer' do
    click_on 'Best'
    within '.other answers' do
      expect(page).to_not have_content answer.body

      within '.best-answer' do
        expect(page).to have_content answer.body
      end
    end
  end
end
