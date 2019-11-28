# frozen_string_literal: true

require "rails_helper"

describe SignUpsController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:require_login) }

  describe "#show" do
    before { expect(SignUpForm).to receive(:new).with(controller: subject) }

    before { get :show }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end

  describe "#create" do
    context "when user successful sign up" do
      let(:form) { instance_double(SignUpForm, save: true) }

      before do
        #
        # SignUpForm.new(email: "me@example.com",
        #                password: "password",
        #                password_confirmation: "password",
        #                remember_me: "1",
        #                controller: self) # => form
        #
        expect(SignUpForm).to receive(:new)
          .with(permitter(email: "me@example.com",
                          password: "password",
                          password_confirmation: "password",
                          remember_me: "1").merge(controller: subject))
          .and_return(form)
      end

      before do
        post :create, params: {
          sign_up: {
            email: "me@example.com",
            password: "password",
            password_confirmation: "password",
            remember_me: "1",
          },
        }
      end

      it { should redirect_to(characters_path) }

      it { should set_flash[:notice].to("Successful signed up!") }
    end

    context "when user not successful sign up" do
      let(:form) { instance_double(SignUpForm, save: false) }

      before do
        #
        # SignUpForm.new(email: "me@example.com",
        #                password: "password",
        #                password_confirmation: "password",
        #                remember_me: "1",
        #                controller: self) # => form
        #
        expect(SignUpForm).to receive(:new)
          .with(permitter(email: "me@example.com",
                          password: "password",
                          password_confirmation: "password",
                          remember_me: "1").merge(controller: subject))
          .and_return(form)
      end

      before do
        post :create, params: {
          sign_up: {
            email: "me@example.com",
            password: "password",
            password_confirmation: "password",
            remember_me: "1",
          },
        }
      end

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end
  end
end
