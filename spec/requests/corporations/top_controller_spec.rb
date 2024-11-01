# frozen_string_literal: true

require "rails_helper"

RSpec.describe Corporations::TopController do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#index" do
    before { create(:eve_corporation, npc: false) }

    before { get corporations_top_index_path }

    context "when user not logged in" do
      it "is expected to render template index with status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("<u>C</u>orporations")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to render template index with status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("<u>C</u>orporations")
      end
    end
  end
end
