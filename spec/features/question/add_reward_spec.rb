# frozen_string_literal: true

require 'rails_helper'

feature 'User can add reward to question', "
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add reward
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author_id: user.id) }

  scenario 'User can add reward ' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Reward name', with: 'reward'
    attach_file 'Reward image', Rails.root.join('spec', 'support', 'images.png')

    click_on 'Ask'

    expect(page).to have_content 'reward'
  end
end
