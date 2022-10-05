# frozen_string_literal: true

require "rails_helper"

describe "/.well-known/change-password" do
  it "when user successfully redirected to change password form" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk")

    visit new_user_session_path

    fill_in "Email address", with: "me@example.com"
    fill_in "Password", with: "eidii7EeooVe8ahk"
    click_on "Sign in"

    visit "/.well-known/change-password"

    expect(current_path).to eq("/users/edit")

    expect(page).to have_content("Change email and password")

    expect(page).to have_content("Password (leave blank if you don't want to change it)")

    expect(page).to have_content("Password confirmation")

    expect(page).to have_content("Current password (we need your current password to confirm your changes)")
  end
end
