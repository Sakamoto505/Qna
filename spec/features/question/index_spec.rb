require 'rails_helper'

feature 'User can see questions and answers', "
  In order to get answer from a community
  As an (un)authenticated user
  I'd like to be able to see list of questions and answers
" do
  before do
    visit question_path(question)
    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)
  end

  describe 'no answers' do
    given(:question) { create(:question) }
    scenario 'the user sees a message about no responses' do
      expect(page).to have_content 'No answers'
    end
  end

  describe 'With answers' do
    given(:question) { create(:question, :with_answers) }
    scenario 'user sees question and answers' do
      expect(page).to have_content(question.answers.first.body, count: 3)
    end
  end
end
