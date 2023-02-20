# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete answer', "
  In order to delete wrong answer
  As an authenticated user
  I'd like to be able to delete answer
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, author: user, question: question) }

  describe 'Authorized user', js: true do
    background do
      sign_in(user)
    end

    scenario 'Authenticated can delete answer' do
      visit question_path(question)
      click_on 'Delete answer'

      expect(page).to_not have_content 'Answer_Body'
    end
  end
end
