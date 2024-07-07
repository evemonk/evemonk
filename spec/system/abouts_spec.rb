# frozen_string_literal: true

require "rails_helper"

RSpec.describe "About feature" do
  before { driven_by(:selenium_chrome_headless) }

  describe "should render page" do
    it "when user not logged in" do
      visit about_path

      expect(page).to have_content("About EveMonk")
    end

    it "when user is logged in" do
      user = create(:user)

      sign_in user

      visit about_path

      expect(page).to have_content("About EveMonk")
    end
  end
end
