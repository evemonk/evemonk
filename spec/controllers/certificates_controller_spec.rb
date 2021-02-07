# frozen_string_literal: true

require "rails_helper"

describe CertificatesController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

  describe "#index" do
    context "when user signed in" do
    end

    context "when user not signed in" do
      before { get :index, params: {character_id: "1"} }

      it { should redirect_to(new_user_session_path) }
    end
  end
end
