# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sign out features" do
  before { driven_by(:selenium_chrome_headless) }

  it "when user successfully sign in and sign out" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    create_list(:eve_alliance, 10)

    visit root_path

    click_link "Log in"

    fill_in "user[email]", with: "me@example.com"
    fill_in "user[password]", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    find_by_id("characters")

    expect(page).to have_current_path("/characters")

    click_link "Sign Out"

    find_by_id("alliances")

    expect(page).to have_current_path(root_path)
  end
end
