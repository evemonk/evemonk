# frozen_string_literal: true

require "rails_helper"

describe "Sign up features" do
  it "when user successfully sign up" do
    visit "/sign_up"

    fill_in "sign_up[email]", with: "me@example.com"
    fill_in "sign_up[password]", with: "eidii7EeooVe8ahk"
    fill_in "sign_up[password_confirmation]", with: "eidii7EeooVe8ahk"

    click_button "Sign up"

    expect(page).to have_content("Successful signed up!")

    expect(current_path).to eq("/characters")

    expect(User.count).to eq(1)
  end

  # it "when email is already taken" do
  #   create(:user, email: "me@example.com")
  #
  #   visit "/sign_up"
  #
  #   fill_in "email", with: "me@example.com"
  #   fill_in "password", with: "eidii7EeooVe8ahk"
  #   fill_in "password_confirmation", with: "eidii7EeooVe8ahk"
  #   find("#sign_up_button").click # TODO: click on 'Sign up'
  #
  #   expect(page).to have_content("has already been taken")
  #
  #   expect(current_path).to eq("/sign_up")
  #
  #   expect(User.count).to eq(1)
  # end
  #
  # it "when password confirmation doesn't match" do
  #   visit "/sign_up"
  #
  #   fill_in "email", with: "me@example.com"
  #   fill_in "password", with: "eidii7EeooVe8ahk"
  #   fill_in "password_confirmation", with: "wrong"
  #   find("#sign_up_button").click # TODO: click on 'Sign up'
  #
  #   expect(page).to have_content("doesn't match Password")
  #
  #   expect(current_path).to eq("/sign_up")
  #
  #   expect(User.count).to eq(0)
  # end
end
