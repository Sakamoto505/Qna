require 'rails_helper'

feature 'User can sign in', %{
  Чтобы задавать вопросы
  Как не аутентифицированный пользователь
  Хочет войти
} do
  scenario 'аутентифицированный пользователь пытается войти ' do
    User.create!(email: 'user@test.com', password: '123123')

    visit '/login'
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '123123'

    expect(page).to have_content 'Signed in successfully.'
  end


  scenario 'не аутентифицированный пользователь пытается войти '
end
