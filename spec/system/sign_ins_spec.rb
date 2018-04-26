# frozen_string_literal: true

require 'rails_helper'

describe 'Sign in features' do
  it 'when user successfully sign ups' do
    create(:user, email: 'me@example.com', password: 'eidii7EeooVe8ahk')

    visit '/sign_in'

    expect {
      fill_in 'email', with: 'me@example.com'
      fill_in 'password', with: 'eidii7EeooVe8ahk'
      click_button 'Sign in'
      wait_for_ajax
    }.to change(Session, :count).by(1)

    expect(current_path).to eq('/')

    expect(page).to have_content('Successful signed in!')
  end
end
