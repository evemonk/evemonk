# frozen_string_literal: true

require "rails_helper"

describe "Admin::Eve::Category's features" do
  describe "#index" do
    context "when user is logged in" do
      context "when user is admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: true)

          sign_in user

          create(:eve_category)

          visit admin_eve_categories_path

          assert current_path == admin_eve_categories_path
        end
      end

      context "when user is not admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: false)

          sign_in user

          create(:eve_category)

          visit admin_eve_categories_path

          assert current_path == root_path
        end
      end
    end

    context "when user is not logged in" do
      it "should render page" do
        create(:eve_category)

        visit admin_eve_categories_path

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

          eve_category = create(:eve_category, id: 1)

          visit admin_eve_category_path(eve_category)

          assert current_path == admin_eve_category_path(eve_category)
        end
      end

      context "when user is not admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: false)

          sign_in user

          eve_category = create(:eve_category, id: 1)

          visit admin_eve_category_path(eve_category)

          assert current_path == root_path
        end
      end
    end

    context "when user is not logged in" do
      it "should render page" do
        eve_category = create(:eve_category, id: 1)

        visit admin_eve_category_path(eve_category)

        assert current_path == new_user_session_path
      end
    end
  end
end
