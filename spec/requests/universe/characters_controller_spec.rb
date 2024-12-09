# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::CharactersController do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#index" do
    let!(:character) { create(:eve_character, name: "Johnn Dillinger") }

    before { get universe_characters_path }

    context "when user not logged in" do
      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Johnn Dillinger")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Johnn Dillinger")
      end
    end
  end

  describe "#show" do
    let!(:alliance) { create(:eve_alliance, name: "The Dead Parrots") }

    let!(:corporation) { create(:eve_corporation, alliance: alliance, name: "Freighting Solutions Inc.") }

    let!(:character) { create(:eve_character, name: "Johnn Dillinger", alliance: alliance, corporation: corporation) }

    let!(:character_corporation_history) do
      create(:eve_character_corporation_history,
        character: character,
        corporation: corporation,
        is_deleted: nil,
        start_date: Time.zone.local(2020, 4, 24, 17, 23, 0))
    end

    before { get universe_character_path(character) }

    context "when user not logged in" do
      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Character: Johnn Dillinger")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Character: Johnn Dillinger")
      end
    end
  end
end
