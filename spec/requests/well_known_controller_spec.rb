# frozen_string_literal: true

require "rails_helper"

RSpec.describe WellKnownController do
  it { should be_an(ApplicationController) }

  describe "#change_password" do
    before { get well_known_change_password_path }

    context "when user not logged in" do
      it "is expected to redirect to edit user registration path with status moved permanently" do
        expect(response).to redirect_to(edit_user_registration_path)

        expect(response).to have_http_status(:moved_permanently)
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to redirect to edit user registration path with status moved permanently" do
        expect(response).to redirect_to(edit_user_registration_path)

        expect(response).to have_http_status(:moved_permanently)
      end
    end
  end
end
