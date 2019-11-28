# frozen_string_literal: true

require "rails_helper"

describe Api::ChangePasswordsController do
  it { should be_a(Api::BaseController) }

  it { should use_before_action(:authenticate) }

  describe "#create" do
    context "when user successful change password" do
      let(:current_user) { instance_double(User) }

      before { api_sign_in(current_user) }

      let(:form) { instance_double(Api::ChangePasswordForm, save: true) }

      before do
        #
        # Api::ChangePasswordForm.new(old_password: 'old_password',
        #                             password: 'new_password',
        #                             password_confirmation: 'new_password',
        #                             name: 'iOS session',
        #                             device_type: 'ios',
        #                             device_token: 'token123',
        #                             user: current_user) # => form
        #
        expect(Api::ChangePasswordForm).to receive(:new)
          .with(permitter(old_password: "old_password",
                          password: "new_password",
                          password_confirmation: "new_password",
                          name: "iOS session",
                          device_type: "ios",
                          device_token: "token123",
                          user: current_user))
          .and_return(form)
      end

      before do
        post :create, params: {
          change_password: {
            old_password: "old_password",
            password: "new_password",
            password_confirmation: "new_password",
            name: "iOS session",
            device_type: "ios",
            device_token: "token123",
          },
          format: :json,
        }
      end

      it { should respond_with(:ok) }

      it { should render_template(:create) }
    end

    context "when user not successful change password" do
      let(:current_user) { instance_double(User) }

      before { api_sign_in(current_user) }

      let(:form) { instance_double(Api::ChangePasswordForm, save: false) }

      before do
        #
        # Api::ChangePasswordForm.new(old_password: 'old_password',
        #                             password: 'new_password',
        #                             password_confirmation: 'new_password',
        #                             name: 'iOS session',
        #                             device_type: 'ios',
        #                             device_token: 'token123',
        #                             user: current_user) # => form
        #
        expect(Api::ChangePasswordForm).to receive(:new)
          .with(permitter(old_password: "old_password",
                          password: "new_password",
                          password_confirmation: "new_password",
                          name: "iOS session",
                          device_type: "ios",
                          device_token: "token123",
                          user: current_user))
          .and_return(form)
      end

      before do
        post :create, params: {
          change_password: {
            old_password: "old_password",
            password: "new_password",
            password_confirmation: "new_password",
            name: "iOS session",
            device_type: "ios",
            device_token: "token123",
          },
          format: :json,
        }
      end

      it { should respond_with(:unprocessable_entity) }

      it { should render_template(:errors) }
    end

    context "when user not signed in" do
      before do
        post :create, params: {
          change_password: {
            old_password: "old_password",
            password: "new_password",
            password_confirmation: "new_password",
            name: "iOS session",
            device_type: "ios",
            device_token: "token123",
          },
          format: :json,
        }
      end

      it { should respond_with(:unauthorized) }
    end

    context "when not supported accept type" do
      before do
        post :create, params: {
          change_password: {
            old_password: "old_password",
            password: "new_password",
            password_confirmation: "new_password",
            name: "iOS session",
            device_type: "ios",
            device_token: "token123",
          },
          format: :html,
        }
      end

      it { should respond_with(:not_acceptable) }
    end
  end
end
