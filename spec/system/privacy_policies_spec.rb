# frozen_string_literal: true

require "rails_helper"

describe "Privacy policy feature" do
  before { driven_by(:selenium_chrome_headless) }

  describe "should render page" do
    it "when user not logged in" do
      visit privacy_policy_path

      expect(page).to have_content("Privacy policy")
    end

    it "when user is logged in" do
      user = create(:user)

      sign_in user

      visit privacy_policy_path

      expect(page).to have_content("Privacy policy")
    end
  end
end
