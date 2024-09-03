# frozen_string_literal: true

require "rails_helper"

RSpec.describe Alliances::TopController do
  it { is_expected.to be_an(ApplicationController) }

  describe "#index" do
    before { create(:eve_alliance) }

    before { get alliances_top_index_path }

    context "when user not logged in" do
      it "is expected to render template index with status ok" do
        expect(response).to render_template(:index)

        expect(response).to have_http_status(:ok)

        expect(response.body).to include("<u>A</u>lliances")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to render template index with status ok" do
        expect(response).to render_template(:index)

        expect(response).to have_http_status(:ok)

        expect(response.body).to include("<u>A</u>lliances")
      end
    end
  end
end
