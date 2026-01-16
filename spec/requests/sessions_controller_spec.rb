# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController, type: :request do
  describe "#new" do
    before { get new_session_path }

    it { expect(response).to have_http_status(:ok) }
  end

  describe "#create" do
    let!(:user) { create(:user, password: "password") }

    context "with valid credentials" do
      before do
        post session_path, params: {
          email_address: user.email_address,
          password: "password"
        }
      end

      it { expect(subject).to redirect_to(characters_path) }

      it { expect(cookies[:session_id]).to be_present }
    end

    context "with invalid credentials" do
      before do
        post session_path, params: {
          email_address: user.email_address,
          password: "wrong"
        }
      end

      it { expect(subject).to redirect_to(new_session_path) }

      it { expect(cookies[:session_id]).to be_blank }
    end
  end

  describe "#destroy" do
    let(:user) { create(:user) }

    before { sign_in_as(user) }

    before { delete session_path }

    it { expect(subject).to redirect_to(root_path) }

    it { expect(cookies[:session_id]).to be_blank }
  end
end
