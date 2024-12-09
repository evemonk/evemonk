# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProfilesController do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#show" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { get profile_path }

      it { expect(response).to have_http_status(:ok) }

      it { expect(response.body).to include("Characters count: 0") }
    end

    context "when user not signed in" do
      before { get profile_path }

      it { expect(response).to have_http_status(:found) }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end
end
