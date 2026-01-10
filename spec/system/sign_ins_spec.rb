# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sign in features", type: :system do
  before { driven_by(:selenium_chrome_headless) }

  it "when user successfully sign in" do
    create(:user, email_address: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit "/"

    click_link "Log in"

    fill_in "email_address", with: "me@example.com"
    fill_in "password", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(page).to have_current_path("/characters")
  end

  it "when user successfully sign in with upper cased email" do
    create(:user, email_address: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit "/"

    click_link "Log in"

    fill_in "email_address", with: "ME@EXAMPLE.COM"
    fill_in "password", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(page).to have_current_path("/characters")
  end

  it "when user with given email not found" do
    visit "/"

    click_link "Log in"

    fill_in "email_address", with: "me@example.com"
    fill_in "password", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    expect(page).to have_content("Try another email address or password.")

    expect(page).to have_current_path("/session/new")
  end

  it "when password wrong" do
    create(:user, email_address: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit "/"

    click_link "Log in"

    fill_in "email_address", with: "me@example.com"
    fill_in "password", with: "wrong-password"

    click_button "Log in"

    expect(page).to have_content("Try another email address or password.")

    expect(page).to have_current_path("/session/new")
  end
end
