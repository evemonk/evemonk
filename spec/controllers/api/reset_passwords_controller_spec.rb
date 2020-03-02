# frozen_string_literal: true

require "rails_helper"

describe Api::ResetPasswordsController do
  it { should be_a(Api::BaseController) }

  describe "#create" do
    context "when user successful reset password" do
      let(:form) { instance_double(Api::ResetPasswordForm, save: true) }

      before do
        #
        # Api::ResetPasswordForm.new(reset_password_token: 'reset-password-token-123',
        #                            password: 'new_password',
        #                            password_confirmation: 'new_password' # => form
        #
        expect(Api::ResetPasswordForm).to receive(:new)
          .with(permitter(reset_password_token: "reset-password-token-123",
                          password: "new_password",
                          password_confirmation: "new_password"))
          .and_return(form)
      end

      before do
        post :create, params: {
          reset_password: {
            reset_password_token: "reset-password-token-123",
            password: "new_password",
            password_confirmation: "new_password"
          },
          format: :json
        }
      end

      it { should respond_with(:ok) }

      it { should render_template(:create) }
    end

    context "when user not successful reset password" do
      let(:form) { instance_double(Api::ResetPasswordForm, save: false) }

      before do
        #
        # Api::ResetPasswordForm.new(reset_password_token: 'reset-password-token-123',
        #                            password: 'new_password',
        #                            password_confirmation: 'new_password' # => form
        #
        expect(Api::ResetPasswordForm).to receive(:new)
          .with(permitter(reset_password_token: "reset-password-token-123",
                          password: "new_password",
                          password_confirmation: "new_password"))
          .and_return(form)
      end

      before do
        post :create, params: {
          reset_password: {
            reset_password_token: "reset-password-token-123",
            password: "new_password",
            password_confirmation: "new_password"
          },
          format: :json
        }
      end

      it { should respond_with(:unprocessable_entity) }

      it { should render_template(:errors) }
    end

    context "when not supported accept type" do
      before do
        post :create, params: {
          reset_password: {
            reset_password_token: "reset-password-token-123",
            password: "new_password",
            password_confirmation: "new_password"
          },
          format: :html
        }
      end

      it { should respond_with(:not_acceptable) }
    end
  end
end
