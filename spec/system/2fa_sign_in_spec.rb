# frozen_string_literal: true

require "rails_helper"

describe "2FA Sign in features" do
  it "when user sign in, enable 2FA, logout and sign in with 2FA code" do
    user = create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    visit root_path

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(page).to have_current_path(characters_path)

    click_link "Profile"

    click_link "Two Factor Authentication"

    click_link "Enable"

    find_by_id "disable-two-factor-auth"

    click_link "Sign Out"

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    fill_in "2FA Code", with: user.reload.current_otp

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(page).to have_current_path(characters_path)
  end

  it "when user sign in with 2FA, disable 2FA, logout and sign in without 2FA" do
    user = create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    user.update!(
      otp_secret: User.generate_otp_secret,
      otp_required_for_login: true
    )

    visit root_path

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    fill_in "2FA Code", with: user.reload.current_otp

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(page).to have_current_path(characters_path)

    click_link "Profile"

    click_link "Two Factor Authentication"

    click_link "Disable"

    find_by_id "enable-two-factor-auth"

    click_link "Sign Out"

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(page).to have_current_path(characters_path)
  end

  it "when user sign in with recovery code" do
    user = create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    backup_code = user.generate_otp_backup_codes!.first

    user.update!(
      otp_secret: User.generate_otp_secret,
      otp_required_for_login: true
    )

    visit root_path

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    fill_in "2FA Code", with: backup_code

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(page).to have_current_path(characters_path)
  end

  it "when user sign in with already used recovery code" do
    user = create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    backup_code = user.generate_otp_backup_codes!.first

    user.update!(
      otp_secret: User.generate_otp_secret,
      otp_required_for_login: true
    )

    visit root_path

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    fill_in "2FA Code", with: backup_code

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(page).to have_current_path(characters_path)

    click_link "Sign Out"

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    fill_in "2FA Code", with: backup_code

    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")

    expect(page).to have_current_path(new_user_session_path)
  end

  it "when user with 2FA try to login without 2FA Code" do
    user = create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    user.update!(
      otp_secret: User.generate_otp_secret,
      otp_required_for_login: true
    )

    visit root_path

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")

    expect(page).to have_current_path(new_user_session_path)
  end

  it "when user try to login with wrong 2FA Code" do
    user = create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    user.update!(
      otp_secret: User.generate_otp_secret,
      otp_required_for_login: true
    )

    visit root_path

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    fill_in "2FA Code", with: "1234567890"

    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")

    expect(page).to have_current_path(new_user_session_path)
  end

  it "when user try to login with expired 2FA Code" do
    user = create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk", locale: "english")

    user.update!(
      otp_secret: User.generate_otp_secret,
      otp_required_for_login: true
    )

    otp = user.reload.current_otp

    visit root_path

    click_link "Log in"

    fill_in "Email address", with: "me@example.com"

    click_button "Next"

    fill_in "Password", with: "eidii7EeooVe8ahk"

    fill_in "2FA Code", with: otp

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")

    expect(page).to have_current_path(characters_path)

    click_link "Sign Out"

    travel 5.minutes do
      click_link "Log in"

      fill_in "Email address", with: "me@example.com"

      click_button "Next"

      fill_in "Password", with: "eidii7EeooVe8ahk"

      fill_in "2FA Code", with: otp

      click_button "Log in"

      expect(page).to have_content("Invalid Email or password.")

      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
