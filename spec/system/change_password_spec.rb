# frozen_string_literal: true

require "rails_helper"

xdescribe "Change password features" do
  it "when user successfully change password" do
    user = create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk")

    create(:session, user: user, token: "token123")

    create(:eve_server_status)

    visit "/"

    page.execute_script <<-JAVASCRIPT
      localStorage.clear();
      localStorage.setItem('token', 'token123');
    JAVASCRIPT

    visit "/change_password"

    expect(page).to have_content("Change password")

    expect(page).to have_content("Current password (leave empty if you are Sign up via Eve Online SSO)")

    expect(page).to have_content("New password")

    expect(page).to have_content("New password confirmation")

    fill_in "old_password", with: "eidii7EeooVe8ahk"
    fill_in "password", with: "7bYu9qK1"
    fill_in "password_confirmation", with: "7bYu9qK1"
    find_by_id("change_password_button").click # TODO: change to 'click'

    expect(page).to have_content("Password was successful changed!")

    current_token = page.evaluate_script <<-JAVASCRIPT
      localStorage.getItem('token');
    JAVASCRIPT

    expect(current_token).not_to eq("token123")

    user.reload

    expect(user.authenticate("eidii7EeooVe8ahk")).to eq(false)

    expect(user.authenticate("7bYu9qK1")).to eq(user)
  end
end
