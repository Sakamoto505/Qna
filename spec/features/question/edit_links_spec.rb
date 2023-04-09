# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit links to question', "
  In order to provide links question
  As an question author
  I'd like to be able to edit links
" do
  describe 'Authenticated user', js: true do
    given(:user) { create(:user) }
    given(:question) { create(:question, author: user) }
    given!(:link) { create(:link, linkable: question) }

    scenario 'Author can edit link' do
      sign_in(user)
      visit question_path(question)
      within all('.question').last do
        click_on 'Edit question'
        find('input[name="question[links_attributes][0][name]"]').set(link.name)
        find('input[name="question[links_attributes][0][url]"]').set(link.url)
        click_on 'Save'
      end

      expect(page).to have_link link.name, href: link.url
    end
  end
end
