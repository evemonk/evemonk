# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Terms of service feature" do
  before { driven_by(:selenium_chrome_headless) }

  describe "should render page" do
    it "when user not logged in" do
      visit terms_of_service_path

      expect(page).to have_content("Terms of Service")
    end

    it "when user is logged in" do
      user = create(:user)

      sign_in user

      visit terms_of_service_path

      expect(page).to have_content("Terms of Service")
    end
  end
end
