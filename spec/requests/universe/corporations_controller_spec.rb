# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::CorporationsController do
  it { expect(subject).to be_a(ApplicationController) }

  describe "#index" do
    let!(:corporation) { create(:eve_corporation, name: "Freighting Solutions Inc.") }

    before { get universe_corporations_path }

    context "when user not logged in" do
      it "is expected to render template index with status ok" do
        expect(response).to render_template(:index)

        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Freighting Solutions Inc.")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to render template index with status ok" do
        expect(response).to render_template(:index)

        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Freighting Solutions Inc.")
      end
    end
  end

  describe "#show" do
    let!(:corporation) { create(:eve_corporation, name: "Freighting Solutions Inc.") }

    before { get universe_corporation_path(corporation) }

    context "when user not logged in" do
      it "is expected to render template show with status ok" do
        expect(response).to render_template(:show)

        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Corporation: Freighting Solutions Inc.")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to render template show with status ok" do
        expect(response).to render_template(:show)

        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Corporation: Freighting Solutions Inc.")
      end
    end
  end
end
