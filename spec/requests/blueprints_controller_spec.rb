# frozen_string_literal: true

require "rails_helper"

RSpec.describe BlueprintsController, type: :request do
  describe "#index" do
    context "when user is signed in" do
      let(:user) { create(:user) }

      let(:character) { create(:character, user: user) }

      before { sign_in_as(user) }

      before { get character_blueprints_path(character) }

      it { expect(response).to have_http_status(:ok) }

      it { expect(response.body).to include("Blueprints") }
    end

    context "when user is not signed in" do
      let(:character) { create(:character) }

      before { get character_blueprints_path(character) }

      it { expect(response).to have_http_status(:found) }

      it { expect(subject).to redirect_to(new_session_path) }
    end
  end

  describe "#show" do
    context "when user is signed in" do
      xcontext "when user is own character" do # rubocop:disable RSpec/PendingWithoutReason
        let(:user) { create(:user) }

        let(:character) { create(:character, user: user, name: "Johnn Dillinger") }

        let(:blueprint) { create(:character_blueprint, character: character) }

        before { sign_in_as(user) }

        before { get character_blueprint_path(character, blueprint.item_id) }

        it { expect(response).to have_http_status(:ok) }

        it { expect(response.body).to include("Johnn Dillinger") }
      end

      context "when user is not own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character) }

        let(:blueprint) { create(:character_blueprint, character: character) }

        before { sign_in_as(user) }

        before { get character_blueprint_path(character, blueprint.item_id) }

        it { expect(response).to have_http_status(:found) }

        it { expect(response).to redirect_to(root_path) }
      end
    end

    context "when user is not signed in" do
      let(:character) { create(:character) }

      let(:blueprint) { create(:character_blueprint, character: character) }

      before { get character_blueprint_path(character, blueprint.item_id) }

      it { expect(response).to have_http_status(:found) }

      it { expect(subject).to redirect_to(new_session_path) }
    end
  end
end
