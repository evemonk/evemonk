# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::CharactersController do
  it { should be_a(ApplicationController) }

  describe "#index" do
    let!(:character) { create(:eve_character, name: "Johnn Dillinger") }

    before { get universe_characters_path }

    context "when user not logged in" do
      it "is expected to render template index with status ok" do
        expect(response).to render_template(:index)

        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Johnn Dillinger")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to render template index with status ok" do
        expect(response).to render_template(:index)

        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Johnn Dillinger")
      end
    end
  end

  describe "#show" do
    let!(:character) { create(:eve_character, name: "Johnn Dillinger") }

    before { get universe_character_path(character) }

    context "when user not logged in" do
      it "is expected to render template show with status ok" do
        expect(response).to render_template(:show)

        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Character: Johnn Dillinger")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to render template show with status ok" do
        expect(response).to render_template(:show)

        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Character: Johnn Dillinger")
      end
    end
  end
end
