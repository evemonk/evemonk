# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::Alliances::CorporationsController do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#index" do
    let!(:alliance) { create(:eve_alliance, name: "The Dead Parrots") }

    let!(:corporation) { create(:eve_corporation, alliance: alliance) }

    before { get universe_alliance_corporations_path(alliance) }

    context "when user not logged in" do
      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Corporations (1)")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Corporations (1)")
      end
    end
  end
end
