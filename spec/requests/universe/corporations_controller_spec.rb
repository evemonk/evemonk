# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::CorporationsController, type: :request do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#index" do
    let!(:corporation) { create(:eve_corporation, name: "Freighting Solutions Inc.") }

    before { get universe_corporations_path }

    context "when user not logged in" do
      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Freighting Solutions Inc.")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Freighting Solutions Inc.")
      end
    end
  end

  describe "#show" do
    let!(:alliance) { create(:eve_alliance) }

    let!(:ceo) { create(:eve_character) }

    let!(:corporation) { create(:eve_corporation, alliance: alliance, ceo: ceo, name: "Freighting Solutions Inc.") }

    before { get universe_corporation_path(corporation) }

    context "when user not logged in" do
      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Corporation: Freighting Solutions Inc.")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Corporation: Freighting Solutions Inc.")
      end
    end
  end
end
