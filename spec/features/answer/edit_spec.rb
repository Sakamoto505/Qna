require 'rails_helper'

feature 'User can edit answer', %q{
  In order to correct mistake in answer
  As an authenticated user
  I'd like to be able to edit answer
} do

  context 'Unauthenticated user' do
    scenario "edits answer" do
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
      expect(page).to_not have_selector 'textarea'
    end
    end
  end
end
