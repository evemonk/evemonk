# frozen_string_literal: true

require "rails_helper"

RSpec.describe BlueprintsController, type: :request do
  describe "#index" do
    context "when user signed in" do
      context "when user is own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character, user: user) }

        before { sign_in(user) }

        before { get character_blueprints_path(character) }

        it { expect(response).to have_http_status(:ok) }

        it { expect(response.body).to include("Blueprints") }
      end

      context "when user is not own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character) }

        before { sign_in(user) }

        before { get character_blueprints_path(character) }

        it { expect(response).to have_http_status(:not_found) }
      end
    end

    context "when user not signed in" do
      let(:character) { create(:character) }

      before { get character_blueprints_path(character) }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe "#show" do
    context "when user signed in" do
      context "when user is own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character, user: user) }

        let(:type) { create(:eve_type) }

        let(:blueprint) { create(:character_blueprint, character: character, item_id: type.id) }

        before { sign_in(user) }

        before { get character_blueprint_path(character, id: blueprint.item_id) }

        it { expect(response).to have_http_status(:ok) }

        it { expect(response.body).to include("Blueprints") }
      end

      context "when user is not own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character, user: user) }

        let(:type) { create(:eve_type) }

        let(:character) { create(:character) }

        let(:blueprint) { create(:character_blueprint, character: character, item_id: type.id) }

        before { sign_in(user) }

        before { get character_blueprint_path(character, blueprint) }

        it { expect(response).to have_http_status(:not_found) }
      end
    end

    context "when user not signed in" do
      let(:character) { create(:character) }

      let(:blueprint) { create(:character_blueprint, character: character) }

      before { get character_blueprint_path(character, blueprint) }

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
