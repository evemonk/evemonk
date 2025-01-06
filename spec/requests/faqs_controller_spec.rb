# frozen_string_literal: true

require "rails_helper"

RSpec.describe FaqsController, type: :request do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#show" do
    before { get faq_path }

    context "when user not logged in" do
      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("FAQ")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("FAQ")
      end
    end
  end
end
