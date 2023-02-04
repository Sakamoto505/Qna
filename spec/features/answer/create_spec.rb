require 'rails_helper'

feature 'User can create answer', "
  In order to give answer to a community
  As an authenticated user
  I'd like to be able to give answer for the question'
" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'answer to a question' do
      fill_in 'Body', with: '1212 1212'
      click_on 'Answer'

      expect(current_path).to eq question_path(question)
      within '.answers' do # чтобы убедиться, что ответ в списке, а не в форме
        expect(page).to have_content '1212 1212'
      end
    end

    scenario 'answers to question with errors' do
      fill_in 'Body', with: ''
      click_on 'Answer'

      expect(page).to have_content "Body can't be blank"
    end
  end
end
