# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProfilesController do
  it { should be_an(ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

  describe "#show" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { get :show }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context "when user not signed in" do
      before { get :show }

      it { should redirect_to(new_user_session_path) }
    end
  end
end
