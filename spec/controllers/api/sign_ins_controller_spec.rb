# frozen_string_literal: true

require "rails_helper"

describe Api::SignInsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe "#create" do
    context "when user successful authorize" do
      let(:form) { instance_double(Api::SignInForm, save: true) }

      before do
        #
        # Api::SignInForm.new(email: 'me@example.com',
        #                     password: 'password',
        #                     name: 'iOS session',
        #                     device_type: 'ios',
        #                     device_token: 'token123') # => form
        #
        expect(Api::SignInForm).to receive(:new)
          .with(permitter(email: "me@example.com",
                          password: "password",
                          name: "iOS session",
                          device_type: "ios",
                          device_token: "token123"))
          .and_return(form)
      end

      before do
        post :create, params: {
          sign_in: {
            email: "me@example.com",
            password: "password",
            name: "iOS session",
            device_type: "ios",
            device_token: "token123"
          },
          format: :json
        }
      end

      it { should respond_with(:ok) }

      it { should render_template(:create) }
    end

    context "when user not successful authorize" do
      let(:form) { instance_double(Api::SignInForm, save: false) }

      before do
        #
        # Api::SignInForm.new(email: 'me@example.com',
        #                     password: 'password',
        #                     name: 'iOS session',
        #                     device_type: 'ios',
        #                     device_token: 'token123') # => form
        #
        expect(Api::SignInForm).to receive(:new)
          .with(permitter(email: "me@example.com",
                          password: "password",
                          name: "iOS session",
                          device_type: "ios",
                          device_token: "token123"))
          .and_return(form)
      end

      before do
        post :create, params: {
          sign_in: {
            email: "me@example.com",
            password: "password",
            name: "iOS session",
            device_type: "ios",
            device_token: "token123"
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
          sign_in: {
            email: "me@example.com",
            password: "password",
            name: "iOS session",
            device_type: "ios",
            device_token: "token123"
          },
          format: :html
        }
      end

      it { should respond_with(:not_acceptable) }
    end
  end
end
