# frozen_string_literal: true

require 'rails_helper'

describe 'Sign in features' do
  it 'when user successfully sign in' do
    create(:user, email: 'me@example.com', password: 'eidii7EeooVe8ahk')

    visit '/sign_in'

    expect {
      fill_in 'email', with: 'me@example.com'
      fill_in 'password', with: 'eidii7EeooVe8ahk'
      find('#sign_in_button').click # TODO: click on 'Sign In'
    }.to change(Session, :count).by(1)

    expect(current_path).to eq('/')

    expect(page).to have_content('Successful signed in!')
  end

  it 'when user successfully sign in with upper cased email' do
    create(:user, email: 'me@example.com', password: 'eidii7EeooVe8ahk')

    visit '/sign_in'

    expect {
      fill_in 'email', with: 'ME@EXAMPLE.COM'
      fill_in 'password', with: 'eidii7EeooVe8ahk'
      find('#sign_in_button').click # TODO: click on 'Sign In'
    }.to change(Session, :count).by(1)

    expect(current_path).to eq('/')

    expect(page).to have_content('Successful signed in!')
  end

  it 'when user with given email not found' do
    visit '/sign_in'

    expect {
      fill_in 'email', with: 'me@example.com'
      fill_in 'password', with: 'eidii7EeooVe8ahk'
      find('#sign_in_button').click # TODO: click on 'Sign In'
    }.not_to change(Session, :count)

    expect(current_path).to eq('/sign_in')

    expect(page).to have_content('Email and/or password is invalid')
  end

  it 'when password wrong' do
    create(:user, email: 'me@example.com', password: 'eidii7EeooVe8ahk')

    visit '/sign_in'

    expect {
      fill_in 'email', with: 'me@example.com'
      fill_in 'password', with: 'wrong-password'
      find('#sign_in_button').click # TODO: click on 'Sign In'
    }.not_to change(Session, :count)

    expect(current_path).to eq('/sign_in')

    expect(page).to have_content('Email and/or password is invalid')
  end
end
