# frozen_string_literal: true

require "rails_helper"

describe "Sign in features" do
  it "when user successfully sign in" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit root_path

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(page).to have_current_path(characters_path)
  end

  it "when user successfully sign in with upper cased email and spaces" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit root_path

    click_link "Log in"

    fill_in "Email address", with: " ME@EXAMPLE.COM "

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(page).to have_current_path(characters_path)
  end

  it "when user with given email not found" do
    visit root_path

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")

    expect(page).to have_current_path(new_user_session_path)
  end

  it "when password wrong" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit root_path

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "wrong-password"

    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")

    expect(page).to have_current_path(new_user_session_path)
  end
end
