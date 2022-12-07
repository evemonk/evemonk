# frozen_string_literal: true

require "rails_helper"

describe "Sign in features" do
  it "when user successfully sign in" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit "/"

    click_link "Log in"

    fill_in "user[email]", with: "me@example.com"
    fill_in "user[password]", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(current_path).to eq("/characters")
  end

  it "when user successfully sign in with upper cased email" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit "/"

    click_link "Log in"

    fill_in "user[email]", with: "ME@EXAMPLE.COM"
    fill_in "user[password]", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(current_path).to eq("/characters")
  end

  it "when user with given email not found" do
    visit "/"

    click_link "Log in"

    fill_in "user[email]", with: "me@example.com"
    fill_in "user[password]", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")

    expect(current_path).to eq("/users/sign_in")
  end

  it "when password wrong" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit "/"

    click_link "Log in"

    fill_in "user[email]", with: "me@example.com"
    fill_in "user[password]", with: "wrong-password"

    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")

    expect(current_path).to eq("/users/sign_in")
  end
end
