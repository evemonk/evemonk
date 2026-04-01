# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::OmniauthCallbacksController, type: :request do
  describe "#eve_online_sso" do
    before { OmniAuth.config.test_mode = true }

    before { OmniAuth.config.mock_auth[:eve_online_sso] = auth }

    after { OmniAuth.config.test_mode = false }

    after { OmniAuth.config.mock_auth[:eve_online_sso] = nil }

    context "when user is not registered in via SSO" do
      let(:auth) do
        OmniAuth::AuthHash.new(
          provider: "eve_online_sso",
          uid: "1337512245"
        )
      end

      it "is expected to create the user and signs in" do
        expect do
          post user_eve_online_sso_omniauth_callback_path
        end.to change(User, :count).by(1)

        user = User.last

        expect(user.provider).to eq("eve_online_sso")
        expect(user.uid).to eq("1337512245")
        expect(response).to redirect_to(characters_path)
      end
    end

    context "when user is already registered in via SSO" do
      let(:auth) do
        OmniAuth::AuthHash.new(
          provider: "eve_online_sso",
          uid: "1337512245"
        )
      end

      it "is expected to sign in the user if already exists" do
        create(:user,
          provider: "eve_online_sso",
          uid: "1337512245",
          email: "1337512245@evemonk.com")

        expect do
          post user_eve_online_sso_omniauth_callback_path
        end.not_to change(User, :count)

        user = User.last

        expect(user.provider).to eq("eve_online_sso")
        expect(user.uid).to eq("1337512245")
        expect(response).to redirect_to(characters_path)
      end
    end

    context "when there is an error with the SSO service" do
      context "when the error is due to invalid credentials" do
        let(:auth) { :invalid_credentials }

        it "is expected to redirect to characters path with an alert" do
          post user_eve_online_sso_omniauth_callback_path

          expect(subject).to redirect_to(new_user_session_path)
        end
      end

      context "when the error is due to a timeout" do
      end
    end
  end
end
