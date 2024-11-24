# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::AlliancesController do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#index" do
    let!(:alliance) { create(:eve_alliance, name: "The Dead Parrots") }

    before { get universe_alliances_path }

    context "when user not logged in" do
      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("The Dead Parrots")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("The Dead Parrots")
      end
    end
  end

  describe "#show" do
    let(:alliance) { create(:eve_alliance, name: "The Dead Parrots") }

    before { get universe_alliance_path(alliance) }

    context "when user not logged in" do
      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Alliance: The Dead Parrots")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Alliance: The Dead Parrots")
      end
    end
  end
end
