# frozen_string_literal: true

require "rails_helper"

RSpec.describe SearchController, type: :request do
  describe "#index" do
    let!(:eve_alliance) { create(:eve_alliance, name: "Test Alliance", ticker: "TEST1") }

    let!(:eve_corporation) { create(:eve_corporation, name: "Test Corporation", ticker: "TEST2") }

    let!(:eve_character) { create(:eve_character, name: "Test Character") }

    context "when user signed in" do
      let!(:user) { create(:user) }

      before { sign_in(user) }

      context "when html request" do
        before { get search_path(q: "TEST") }

        it { expect(response).to have_http_status(:ok) }

        it { expect(response.body).to include("Search") }
      end

      context "when turbo frame request" do
        before do
          get search_path(q: "TEST"), headers: {
            "Turbo-Frame" => "search"
          }
        end

        it { expect(response).to have_http_status(:ok) }

        it { expect(response.body).not_to include("Search") }
      end
    end

    context "when user not signed in" do
      context "when html request" do
        before { get search_path(q: "TEST") }

        it { expect(response).to have_http_status(:ok) }

        it { expect(response.body).to include("Search") }
      end

      context "when turbo frame request" do
        before do
          get search_path(q: "TEST"), headers: {
            "Turbo-Frame" => "search"
          }
        end

        it { expect(response).to have_http_status(:ok) }

        it { expect(response.body).not_to include("Search") }
      end
    end
  end
end
