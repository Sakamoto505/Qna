# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit links to answer', "
  In order to provide links answer
  As an answer author
  I'd like to be able to edit links
" do
  describe 'Authenticated user', js: true do
    given(:user) { create(:user) }
    given(:question) { create(:question, author: user) }
    given!(:answer) { create(:answer, author: user, question: question) }
    given!(:link) { create(:link, linkable: answer) }

    scenario 'Author can edit link' do
      sign_in(user)
      visit question_path(question)

      within '.answers' do
        click_on 'Edit answer'

        find('input[name="answer[links_attributes][0][name]"]').set(link.name)
        find('input[name="answer[links_attributes][0][url]"]').set(link.url)
        click_on 'Save'
      end

      expect(page).to have_link link.name, href: link.url
    end
  end
end
