require 'rails_helper'

feature 'User can sign up', %(
  wants to register
) do
  background do
    visit new_user_registration_path
    fill_in 'Email', with: 'email@test.qna'
  end

  scenario 'The user wants to register in the system' do
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'Unregistered user tries to sign up with errors' do
    fill_in 'Password', with: '12345'
    fill_in 'Password confirmation', with: '12345'

    click_on 'Sign up'

    expect(page).to have_content 'Password is too short (minimum is 6 characters)'
  end

  scenario 'Confirmation password and password do not match' do
    fill_in 'Password', with: '1234567'
    fill_in 'Password confirmation', with: '1234568'

    click_on 'Sign up'

    expect(page).to have_content "Password confirmation doesn't match Password"
  end
end
