require 'rails_helper'

describe 'Sign up features' do
  it 'when user successfully sign ups' do
    visit '/sign_up'

    expect {
      fill_in 'email', with: 'me@example.com'
      fill_in 'password', with: 'eidii7EeooVe8ahk'
      fill_in 'password_confirmation', with: 'eidii7EeooVe8ahk'
      click_button 'Sign up'
      wait_for_ajax
    }.to change(User, :count).by(1)

    expect(current_path).to eq('/')

    expect(page).to have_content('Successful signed in!')
  end
end
