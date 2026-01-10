# frozen_string_literal: true

require "rails_helper"

RSpec.describe WellKnownController, type: :request do
  describe "#change_password" do
    context "when user is not logged in" do
      before { get well_known_change_password_path }

      it { expect(response).to have_http_status(:found) }

      it { expect(response).to redirect_to(new_session_path) }
    end

    context "when user is signed in" do
      before { freeze_time }

      let(:user) { create(:user) }

      before { sign_in_as(user) }

      before { get well_known_change_password_path }

      it { expect(response).to have_http_status(:moved_permanently) }

      it { expect(response).to redirect_to(edit_password_path(user.password_reset_token)) }
    end
  end
end
