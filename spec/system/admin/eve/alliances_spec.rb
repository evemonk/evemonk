# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Eve::Alliance's features" do
  before { driven_by(:selenium_chrome_headless) }

  describe "#index" do
    context "when user is logged in" do
      context "when user is admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: true)

          sign_in user

          create(:eve_alliance)

          visit admin_eve_alliances_path

          assert current_path == admin_eve_alliances_path
        end
      end

      context "when user is not admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: false)

          sign_in user

          create(:eve_alliance)

          visit admin_eve_alliances_path

          assert current_path == root_path
        end
      end
    end

    context "when user is not logged in" do
      it "should render page" do
        create(:eve_alliance)

        visit admin_eve_alliances_path

        assert current_path == new_user_session_path
      end
    end
  end

  describe "#show" do
    context "when user is logged in" do
      context "when user is admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: true)

          sign_in user

          eve_alliance = create(:eve_alliance)

          visit admin_eve_alliance_path(eve_alliance)

          assert current_path == admin_eve_alliance_path(eve_alliance)
        end
      end

      context "when user is not admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: false)

          sign_in user

          eve_alliance = create(:eve_alliance)

          visit admin_eve_alliance_path(eve_alliance)

          assert current_path == root_path
        end
      end
    end

    context "when user is not logged in" do
      it "should render page" do
        eve_alliance = create(:eve_alliance)

        visit admin_eve_alliance_path(eve_alliance)

        assert current_path == new_user_session_path
      end
    end
  end
end
