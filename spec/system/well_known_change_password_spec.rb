# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/.well-known/change-password", type: :system do
  before { driven_by(:selenium_chrome_headless) }
  # before { driven_by(:selenium_chrome) }

  it "when user successfully redirected to change password form" do
    create(:user, email_address: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit new_session_path

    fill_in "email_address", with: "me@example.com"
    fill_in "password", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    find_by_id("characters")

    visit "/.well-known/change-password"

    # binding.pry
    #
    # find_by_id("edit_user")
    #
    # expect(page).to have_current_path("/users/edit")
    #
    # expect(page).to have_content("Change email and password")
    #
    # expect(page).to have_content("Email address")
    #
    # expect(page).to have_content("Password (leave blank if you don't want to change it)")
    #
    # expect(page).to have_content("Password confirmation")
    #
    # expect(page).to have_content("Current password")
    #
    # expect(page).to have_content("we need your current password to confirm your changes")
  end
end
