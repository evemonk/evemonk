# frozen_string_literal: true

require "rails_helper"

describe "Admin::Eve::Icon's features" do
  describe "#index" do
    context "when user is logged in" do
      context "when user is admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: true)

          sign_in user

          create(:eve_icon)

          visit admin_eve_icons_path

          assert current_path == admin_eve_icons_path
        end
      end

      context "when user is not admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: false)

          sign_in user

          create(:eve_icon)

          visit admin_eve_icons_path

          assert current_path == root_path
        end
      end
    end

    context "when user is not logged in" do
      it "should render page" do
        create(:eve_icon)

        visit admin_eve_icons_path

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

          eve_icon = create(:eve_icon)

          visit admin_eve_icon_path(eve_icon)

          assert current_path == admin_eve_icon_path(eve_icon)
        end
      end

      context "when user is not admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: false)

          sign_in user

          eve_icon = create(:eve_icon)

          visit admin_eve_icon_path(eve_icon)

          assert current_path == root_path
        end
      end
    end

    context "when user is not logged in" do
      it "should render page" do
        eve_icon = create(:eve_icon)

        visit admin_eve_icon_path(eve_icon)

        assert current_path == new_user_session_path
      end
    end
  end
end
