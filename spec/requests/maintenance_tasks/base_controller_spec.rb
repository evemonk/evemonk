# frozen_string_literal: true

require "rails_helper"

RSpec.describe MaintenanceTasks::BaseController, type: :request do
  describe "#index" do
    context "when user signed in" do
      context "when user is admin" do
        let(:user) { create(:user, admin: true) }

        before { sign_in(user) }

        before { get maintenance_tasks_path }

        it { expect(response).to have_http_status(:ok) }

        it { expect(response.body).to include("Maintenance Tasks") }
      end

      context "when user is not admin" do
        let(:user) { create(:user, admin: false) }

        before { sign_in(user) }

        before { get maintenance_tasks_path }

        it { expect(response).to have_http_status(:found) }

        it { expect(subject).to redirect_to("/") }
      end
    end

    context "when user not signed in" do
      before { get maintenance_tasks_path }

      it { expect(response).to have_http_status(:found) }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end
end
