# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::AgentsController do
  describe "#index" do
    context "when user is logged in" do
      context "when user is admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: true)

          sign_in user

          create(:eve_agent)

          get admin_eve_agents_path

          expect(response).to render_template(:index)

          expect(response).to have_http_status(:ok)
        end
      end

      context "when user is not admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: false)

          sign_in user

          create(:eve_agent)

          get admin_eve_agents_path

          expect(response).to redirect_to(root_path)

          expect(response).to have_http_status(:found)
        end
      end
    end

    context "when user is not logged in" do
      it "should render page" do
        create(:eve_agent)

        visit admin_eve_agents_path

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

          eve_agent = create(:eve_agent)

          visit admin_eve_agent_path(eve_agent)

          assert current_path == admin_eve_agent_path(eve_agent)
        end
      end

      context "when user is not admin" do
        it "should render page" do
          user = create(:user, locale: :english, admin: false)

          sign_in user

          eve_agent = create(:eve_agent)

          visit admin_eve_agent_path(eve_agent)

          assert current_path == root_path
        end
      end
    end

    context "when user is not logged in" do
      it "should render page" do
        eve_agent = create(:eve_agent)

        visit admin_eve_agent_path(eve_agent)

        assert current_path == new_user_session_path
      end
    end
  end
end
