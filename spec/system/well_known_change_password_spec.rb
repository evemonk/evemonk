# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/.well-known/change-password", type: :system do
  it "when user successfully redirected to change password form" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit new_user_session_path

    fill_in "Email address", with: "me@example.com"
    fill_in "Password", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    find_by_id("characters")

    visit "/.well-known/change-password"

    find_by_id("edit_user")

    expect(page).to have_current_path("/users/edit")

    expect(page).to have_text("Change email and password")

    expect(page).to have_text("Email address")

    expect(page).to have_text("Password (leave blank if you don't want to change it)")

    expect(page).to have_text("Password confirmation")

    expect(page).to have_text("Current password")

    expect(page).to have_text("we need your current password to confirm your changes")
  end
end
