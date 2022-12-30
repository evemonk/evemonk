# frozen_string_literal: true

require "rails_helper"

describe Auth::EveOnlineSso::CallbacksController do
  it { should be_a(ApplicationController) }

  it { should rescue_from(EveOnline::Exceptions::ServiceUnavailable).with(:handle_service_unavailable) }

  it { should rescue_from(EveOnline::Exceptions::InternalServerError).with(:handle_internal_server_error) }

  it { should rescue_from(EveOnline::Exceptions::BadGateway).with(:handle_bad_gateway) }

  it { should rescue_from(EveOnline::Exceptions::Timeout).with(:handle_timeout) }

  describe "#show" do
    let(:user) { create(:user, locale: "english") }

    before { sign_in(user) }

    before { expect(subject).to receive(:current_user).and_return(user).exactly(4).times }

    let(:service) { instance_double(EveOnlineCallbackService) }

    before do
      #
      # EveOnlineCallbackService.new(current_user, request) # => service
      #
      expect(EveOnlineCallbackService).to receive(:new).with(any_args).and_return(service) # TODO: replace `any_args` with real data
    end

    context "when successful" do
      before { expect(service).to receive(:save!) }

      before { get :show }

      it { should respond_with(:found) }

      it { should redirect_to("/characters") }
    end

    context "when service unavailable" do
      before { expect(service).to receive(:save!).and_raise(EveOnline::Exceptions::ServiceUnavailable) }

      before { get :show }

      it { should respond_with(:found) }

      it { should redirect_to("/characters") }

      it { should set_flash[:alert].to("Service Unavailable (503). Please, try again later.") }
    end

    context "when service unavailable" do
      before { expect(service).to receive(:save!).and_raise(EveOnline::Exceptions::InternalServerError) }

      before { get :show }

      it { should respond_with(:found) }

      it { should redirect_to("/characters") }

      it { should set_flash[:alert].to("Internal Server Error (500). Please, try again later.") }
    end

    context "when bad gateway" do
      before { expect(service).to receive(:save!).and_raise(EveOnline::Exceptions::BadGateway) }

      before { get :show }

      it { should respond_with(:found) }

      it { should redirect_to("/characters") }

      it { should set_flash[:alert].to("Bad Gateway (502). Please, try again later.") }
    end

    context "when timeout" do
      before { expect(service).to receive(:save!).and_raise(EveOnline::Exceptions::Timeout) }

      before { get :show }

      it { should respond_with(:found) }

      it { should redirect_to("/characters") }

      it { should set_flash[:alert].to("Timeout Error. Please, try again later.") }
    end
  end
end
