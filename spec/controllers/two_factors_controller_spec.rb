# frozen_string_literal: true

require "rails_helper"

describe TwoFactorsController do
  it { should be_an(ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

  describe "#show" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

      before { get :show }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context "when user not signed in" do
      before { get :show }

      it { should redirect_to(new_user_session_path) }
    end
  end

  describe "#create" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

      before { expect(subject).to receive(:current_user).and_return(user).twice }

      before { expect(user).to receive(:generate_otp_backup_codes!) }

      let(:otp_secret) { double }

      before { expect(User).to receive(:generate_otp_secret).and_return(otp_secret) }

      before do
        #
        # current_user.update!(
        #   otp_secret: User.generate_otp_secret,
        #   otp_required_for_login: true
        # )
        #
        expect(user).to receive(:update!).with(
          otp_secret: otp_secret,
          otp_required_for_login: true
        )
      end

      before { post :create, params: {format: "turbo_stream"} }

      it { should respond_with(:ok) }

      it { should render_template(:create) }
    end

    context "when user not signed in" do
      before { post :create, params: {format: "turbo_stream"} }

      it { should redirect_to(new_user_session_path) }
    end
  end

  describe "#destroy" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

      before { expect(subject).to receive(:current_user).and_return(user) }

      before do
        #
        # current_user.update!(
        #   otp_required_for_login: false,
        #   otp_secret: nil,
        #   otp_backup_codes: nil
        # )
        #
        expect(user).to receive(:update!).with(
          otp_required_for_login: false,
          otp_secret: nil,
          otp_backup_codes: nil
        )
      end

      before { delete :destroy, params: {format: "turbo_stream"} }

      it { should respond_with(:ok) }

      it { should render_template(:destroy) }
    end

    context "when user not signed in" do
      before { delete :destroy, params: {format: "turbo_stream"} }

      it { should redirect_to(new_user_session_path) }
    end
  end
end
