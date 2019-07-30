# frozen_string_literal: true

require "rails_helper"

describe Api::SignUpsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe "#create" do
    context "when form valid" do
      let(:session) { instance_double(Session) }

      let(:form) { instance_double(Api::SignUpForm, session: session, save: true) }

      before do
        #
        # Api::SignUpForm.new(email: 'me@example.com',
        #                     password: 'password',
        #                     password_confirmation: 'password') # => form
        #
        expect(Api::SignUpForm).to receive(:new).with(permitter(email: "me@example.com",
                                                                password: "password",
                                                                password_confirmation: "password"))
          .and_return(form)
      end

      before do
        post :create, params: {
          sign_up: {
            email: "me@example.com",
            password: "password",
            password_confirmation: "password",
          },
          format: :json,
        }
      end

      it { should respond_with(:ok) }

      it { should render_template(:create) }
    end

    context "when form not valid" do
      let(:errors) { instance_double(ActiveModel::Errors) }

      let(:form) { instance_double(Api::SignUpForm, errors: errors, save: false) }

      before do
        #
        # Api::SignUpForm.new(email: 'me@example.com',
        #                 password: 'password',
        #                 password_confirmation: 'password') # => form
        #
        expect(Api::SignUpForm).to receive(:new).with(permitter(email: "me@example.com",
                                                                password: "password",
                                                                password_confirmation: "another password"))
          .and_return(form)
      end

      before do
        post :create, params: {
          sign_up: {
            email: "me@example.com",
            password: "password",
            password_confirmation: "another password",
          },
          format: :json,
        }
      end

      it { should respond_with(:unprocessable_entity) }

      it { should render_template(:errors) }
    end

    context "when not supported accept type" do
      before do
        post :create, params: {
          sign_up: {
            email: "me@example.com",
            password: "password",
            password_confirmation: "password",
          },
          format: :html,
        }
      end

      it { should respond_with(:not_acceptable) }
    end
  end
end
