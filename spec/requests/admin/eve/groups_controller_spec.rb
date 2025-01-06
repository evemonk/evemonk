# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::GroupsController, type: :request do
  it { expect(subject).to be_an(Admin::ApplicationController) }

  describe "#index" do
    context "when user is logged in" do
      context "when user is admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: true)

          sign_in user

          create(:eve_group)

          get admin_eve_groups_path

          expect(response).to have_http_status(:ok)
        end
      end

      context "when user is not admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: false)

          sign_in user

          create(:eve_group)

          get admin_eve_groups_path

          expect(response).to redirect_to(root_path)

          expect(response).to have_http_status(:found)
        end
      end
    end

    context "when user is not logged in" do
      it "should render page" do
        create(:eve_group)

        get admin_eve_groups_path

        expect(response).to redirect_to(new_user_session_path)

        expect(response).to have_http_status(:found)
      end
    end
  end

  describe "#show" do
    context "when user is logged in" do
      context "when user is admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: true)

          sign_in user

          eve_group = create(:eve_group)

          get admin_eve_group_path(eve_group)

          expect(response).to have_http_status(:ok)
        end
      end

      context "when user is not admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: false)

          sign_in user

          eve_group = create(:eve_group)

          get admin_eve_group_path(eve_group)

          expect(response).to redirect_to(root_path)

          expect(response).to have_http_status(:found)
        end
      end
    end

    context "when user is not logged in" do
      it "should render page" do
        eve_group = create(:eve_group)

        get admin_eve_group_path(eve_group)

        expect(response).to redirect_to(new_user_session_path)

        expect(response).to have_http_status(:found)
      end
    end
  end
end
