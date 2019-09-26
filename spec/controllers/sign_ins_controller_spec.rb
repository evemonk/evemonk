# frozen_string_literal: true

require "rails_helper"

describe SignInsController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:require_login) }

  describe "#show" do
    before { expect(SignInService).to receive(:new).with(controller: subject) }

    before { get :show }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end

  describe "#create" do
    context "when user successful authorize" do
      let(:service) { instance_double(SignInService, save: true) }

      before do
        #
        # SignInService.new(email: "me@example.com",
        #                   password: "password",
        #                   remember_me: "1",
        #                   controller: self) # => service
        #
        expect(SignInService).to receive(:new)
                                       .with(permitter(email: "me@example.com",
                                                       password: "password",
                                                       remember_me: "1")
                                                 .merge(controller: subject))
                                       .and_return(service)
      end

      before do
        post :create, params: {
          sign_in: {
            email: "me@example.com",
            password: "password",
            remember_me: "1",
          },
        }
      end

      it { should redirect_to(characters_path) }

      it { should set_flash[:notice].to("Successful signed in!") }
    end

    context "when user not successful authorize" do
      let(:service) { instance_double(SignInService, save: false) }

      before do
        #
        # SignInService.new(email: "me@example.com",
        #                   password: "password",
        #                   remember_me: "1",
        #                   controller: self) # => service
        #
        expect(SignInService).to receive(:new)
                                     .with(permitter(email: "me@example.com",
                                                     password: "password",
                                                     remember_me: "1")
                                               .merge(controller: subject))
                                     .and_return(service)
      end

      before do
        post :create, params: {
          sign_in: {
            email: "me@example.com",
            password: "password",
            remember_me: "1",
          },
        }
      end

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end
  end
end
