# frozen_string_literal: true

require "rails_helper"

describe "/.well-known/change-password" do
  it "when user successfully redirected to change password form" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk")

    visit "/sign_in"

    fill_in "email", with: "me@example.com"
    fill_in "password", with: "eidii7EeooVe8ahk"
    find("#sign_in_button").click # TODO: click on 'Sign In'

    visit "/.well-known/change-password"

    expect(current_path).to eq("/change_password")

    expect(page).to have_content("Change password")

    expect(page).to have_content("Current password (leave empty if you are Sign up via Eve Online SSO)")

    expect(page).to have_content("New password")

    expect(page).to have_content("New password confirmation")
  end
end
