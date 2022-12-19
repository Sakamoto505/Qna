require 'rails_helper'

feature 'User can sign out', %{
  The user is logged in and
  then wants to log out
} do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit questions_path
    click_on "Ask question"
  end

  scenario 'The user wants to log out' do
    click_on 'Logout'
    expect(page).to have_content "Signed out successfully."
  end
end
