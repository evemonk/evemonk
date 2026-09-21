# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Flipper engine", type: :request do
  describe "#index" do
    context "when user signed in" do
      context "when user is admin" do
        let(:user) { create(:user, admin: true) }

        before { sign_in(user) }

        before { get "/flipper/features" }

        it { expect(response).to have_http_status(:ok) }

        it { expect(response.body).to include("Features // Flipper") }
      end

      context "when user is not admin" do
        let(:user) { create(:user, admin: false) }

        before { sign_in(user) }

        before { get "/flipper/features" }

        it { expect(response).to have_http_status(:not_found) }
      end
    end

    context "when user not signed in" do
      before { get "/flipper/features" }

      it { expect(response).to have_http_status(:found) }

      it { expect(subject).to redirect_to("/users/sign_in") }
    end
  end
end
