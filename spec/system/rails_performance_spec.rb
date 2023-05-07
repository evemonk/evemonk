# frozen_string_literal: true

require "rails_helper"

describe "Rails performance dashboard" do
  before { driven_by(:selenium_chrome_headless) }

  describe "should render page" do
    it "when user not logged in" do
      visit rails_performance_path

      expect(page).to have_content("You are being redirected.")
    end

    it "when user is logged in" do
      user = create(:user, admin: false)

      sign_in user

      visit rails_performance_path

      expect(page).to have_content("You are being redirected.")
    end

    it "when admin is logged in" do
      user = create(:user, admin: true)

      sign_in user

      visit rails_performance_path

      expect(page).not_to have_content("You are being redirected.")
    end
  end
end
