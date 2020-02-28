# frozen_string_literal: true

require "rails_helper"

describe Api::RequestPasswordResetsController do
  it { should be_a(Api::BaseController) }

  describe "#create" do
    context "when user successful request password reset" do
      let(:form) { instance_double(Api::RequestResetPasswordForm, save: true) }

      before do
        #
        # Api::RequestResetPasswordForm.new(email: 'me@example.com') # => form
        #
        expect(Api::RequestResetPasswordForm).to receive(:new)
          .with(permitter(email: "me@example.com"))
          .and_return(form)
      end

      before do
        post :create, params: {
          request_password_reset: {
            email: "me@example.com"
          },
          format: :json
        }
      end

      it { should respond_with(:ok) }
    end

    context "when user not successful request password reset" do
      let(:form) { instance_double(Api::RequestResetPasswordForm, save: false) }

      before do
        #
        # Api::RequestResetPasswordForm.new(email: 'me@example.com') # => form
        #
        expect(Api::RequestResetPasswordForm).to receive(:new)
          .with(permitter(email: "me@example.com"))
          .and_return(form)
      end

      before do
        post :create, params: {
          request_password_reset: {
            email: "me@example.com"
          },
          format: :json
        }
      end

      it { should respond_with(:unprocessable_entity) }

      it { should render_template(:errors) }
    end
  end
end
