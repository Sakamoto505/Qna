# frozen_string_literal: true

require 'rails_helper'

feature 'User can comment question/answer', "
  In order to add comment to community
  As an authenticated user
  I'd like to be able to comment to question/answer
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, author: user, question: question) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'comments to question' do
      within '.question' do
        fill_in 'Your comment', with: 'simple comment'
        click_on 'Save Comment'

        expect(page).to have_content 'simple comment'
      end
    end

    scenario 'comments to answer' do
      within '.answer' do
        fill_in 'Your comment', with: 'simple comment'
        click_on 'Save Comment'

        expect(page).to have_content 'simple comment'
      end
    end

    context 'multiple sessions', js: true do
      scenario 'comment appears on another user\'s page' do
        Capybara.using_session('guest') do
          visit question_path(question)
        end

        Capybara.using_session('user') do
          sign_in(user)
          visit question_path(question)

          within '.question' do
            fill_in 'Your comment', with: 'simple comment'
            click_on 'Save Comment'

            expect(page).to have_content 'simple comment'
          end
        end

        Capybara.using_session('guest') do
          expect(page).to have_content('simple comment')
        end
      end
    end
  end

  describe 'Unauthenticated user' do
    scenario 'tries to answer to question' do
      visit question_path(question)
      expect(page).to_not have_link 'Comment'
    end
  end
end
