# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::Corporations::CharactersController do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#index" do
    let!(:corporation) { create(:eve_corporation) }

    let!(:character) { create(:eve_character, corporation: corporation) }

    before { get universe_corporation_characters_path(corporation) }

    context "when user not logged in" do
      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Members (1)")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Members (1)")
      end
    end
  end
end
