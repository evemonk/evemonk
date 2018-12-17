# frozen_string_literal: true

require 'rails_helper'

describe 'Sign up features' do
  it 'when user successfully sign up' do
    visit '/sign_up'

    expect {
      fill_in 'email', with: 'me@example.com'
      fill_in 'password', with: 'eidii7EeooVe8ahk'
      fill_in 'password_confirmation', with: 'eidii7EeooVe8ahk'
      click_button 'Sign up'
    }.to change(User, :count).by(1)

    expect(current_path).to eq('/')

    expect(page).to have_content('Successful signed up!')
  end

  it 'when email is already taken' do
    create(:user, email: 'me@example.com')

    visit '/sign_up'

    expect {
      fill_in 'email', with: 'me@example.com'
      fill_in 'password', with: 'eidii7EeooVe8ahk'
      fill_in 'password_confirmation', with: 'eidii7EeooVe8ahk'
      click_button 'Sign up'
    }.not_to change(User, :count)

    expect(current_path).to eq('/sign_up')

    expect(page).to have_content('has already been taken')
  end

  it "when password confirmation doesn't match" do
    visit '/sign_up'

    expect {
      fill_in 'email', with: 'me@example.com'
      fill_in 'password', with: 'eidii7EeooVe8ahk'
      fill_in 'password_confirmation', with: 'wrong'
      click_button 'Sign up'
    }.not_to change(User, :count)

    expect(current_path).to eq('/sign_up')

    expect(page).to have_content("doesn't match Password")
  end
end
