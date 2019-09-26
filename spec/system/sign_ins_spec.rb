# frozen_string_literal: true

require "rails_helper"

describe "Sign in features" do
  it "when user successfully sign in" do
    user = create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk")

    # create(:eve_server_status)

    visit "/sign_in"

    fill_in "sign_in[email]", with: "me@example.com"
    fill_in "sign_in[password]", with: "eidii7EeooVe8ahk"

    # find("Sign in").click # TODO: click on 'Sign In'

    click_button "Sign in"

    # expect(page).to have_content("Successful signed in!")

    expect(current_path).to eq("/characters")

    # expect(user.sessions.count).to eq(1)
  end

  # it "when user successfully sign in with upper cased email" do
  #   user = create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk")
  #
  #   create(:eve_server_status)
  #
  #   visit "/sign_in"
  #
  #   fill_in "email", with: "ME@EXAMPLE.COM"
  #   fill_in "password", with: "eidii7EeooVe8ahk"
  #   find("#sign_in_button").click # TODO: click on 'Sign In'
  #
  #   expect(page).to have_content("Successful signed in!")
  #
  #   expect(current_path).to eq("/profile")
  #
  #   expect(user.sessions.count).to eq(1)
  # end

  # it "when user with given email not found" do
  #   create(:eve_server_status)
  #
  #   visit "/sign_in"
  #
  #   fill_in "email", with: "me@example.com"
  #   fill_in "password", with: "eidii7EeooVe8ahk"
  #   find("#sign_in_button").click # TODO: click on 'Sign In'
  #
  #   expect(page).to have_content("Email and/or password is invalid")
  #
  #   expect(current_path).to eq("/sign_in")
  #
  #   expect(Session.count).to eq(0)
  # end
  #
  # it "when password wrong" do
  #   create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk")
  #
  #   create(:eve_server_status)
  #
  #   visit "/sign_in"
  #
  #   fill_in "email", with: "me@example.com"
  #   fill_in "password", with: "wrong-password"
  #   find("#sign_in_button").click # TODO: click on 'Sign In'
  #
  #   expect(page).to have_content("Email and/or password is invalid")
  #
  #   expect(current_path).to eq("/sign_in")
  #
  #   expect(Session.count).to eq(0)
  # end
end
