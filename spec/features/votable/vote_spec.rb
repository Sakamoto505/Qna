# frozen_string_literal: true

require 'rails_helper'

feature 'User can vote for the answer or question', "
  In order to be able to change the rating
  As an authenticated user
  I'd like to be able put a like or dislike
" do
  given(:user) { create(:user) }
  given!(:user_not_author) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, author: user, question: question) }

  describe 'Authenticated user_not_author', js: true do
    background do
      sign_in(user_not_author)
      visit question_path(question)
    end

    scenario 'like for the another question' do
      within all('.question').last do
        click_on '+'

        expect(page).to have_content '1'
      end
    end

    scenario 'dislike for the another question' do
      within all('.question').last do
        click_on '-'

        expect(page).to have_content '-1'
      end
    end

    scenario 'cancel vote for the another question' do
      within all('.question').last do
        click_on '+'
        expect(page).to have_content '1'

        click_on 'Cancel vote'
        expect(page).to have_content '0'
      end
    end

    scenario 'like for the another answer' do
      within '.answers' do
        click_on '+'

        expect(page).to have_content '1'
      end
    end

    scenario 'dislike for the another answer' do
      within '.answers' do
        click_on '-'

        expect(page).to have_content '-1'
      end
    end

    scenario 'cancel vote for the another answer' do
      within '.answers' do
        click_on '+'
        expect(page).to have_content '1'

        click_on 'Cancel vote'
        expect(page).to have_content '0'
      end
    end
  end
end
