# frozen_string_literal: true

require "rails_helper"

RSpec.describe EmploymentHistoriesController, type: :request do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#index" do
    context "when user signed in" do
      context "when user is own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character, user: user) }

        before { sign_in(user) }

        before { get character_employment_histories_path(character) }

        it { expect(response).to have_http_status(:ok) }

        it { expect(response.body).to include("Employment History (0)") }
      end

      context "when user is not own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character) }

        before { sign_in(user) }

        before { get character_employment_histories_path(character) }

        it { expect(response).to have_http_status(:not_found) }
      end
    end

    context "when user not signed in" do
      let(:character) { create(:character) }

      before { get character_employment_histories_path(character) }

      it { expect(response).to have_http_status(:found) }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end
end
