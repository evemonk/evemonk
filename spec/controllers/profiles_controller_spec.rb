# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProfilesController do
  it { is_expected.to be_an(ApplicationController) }

  it { is_expected.to use_before_action(:authenticate_user!) }

  describe "#show" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { get :show }

      it { is_expected.to respond_with(:ok) }

      it { is_expected.to render_template(:show) }
    end

    context "when user not signed in" do
      before { get :show }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
end
