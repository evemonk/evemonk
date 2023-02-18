# frozen_string_literal: true

require "rails_helper"

describe "Sign out features" do
  it "when user successfully sign in and sign out" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit root_path

    click_link "Log in"

    fill_in "user[email]", with: "me@example.com"
    fill_in "user[password]", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    find("#characters")

    expect(current_path).to eq("/characters")

    click_link "Sign Out"

    find("#alliances")

    expect(current_path).to eq(root_path)
  end
end
