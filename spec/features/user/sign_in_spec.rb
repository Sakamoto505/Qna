require 'rails_helper'

feature 'User can sign in', %{
   To ask questions
   As an unauthenticated user
   Wants to sign in
} do

  given(:user) { create(:user) }

  background { visit new_user_session_path }

  scenario 'authenticated user is trying to login' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'an unauthenticated user is trying to login' do
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '123123'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password'
  end
end
