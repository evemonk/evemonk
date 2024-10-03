# frozen_string_literal: true

require "rails_helper"

RSpec.describe Auth::EveOnlineSso::CallbacksController do
  it { is_expected.to be_a(ApplicationController) }

  it { is_expected.to rescue_from(EveOnline::Exceptions::ServiceUnavailable).with(:handle_service_unavailable) }

  it { is_expected.to rescue_from(EveOnline::Exceptions::InternalServerError).with(:handle_internal_server_error) }

  it { is_expected.to rescue_from(EveOnline::Exceptions::BadGateway).with(:handle_bad_gateway) }

  it { is_expected.to rescue_from(EveOnline::Exceptions::Timeout).with(:handle_timeout) }

  describe "#show" do
    let(:user) { create(:user, locale: "english") }

    before { sign_in(user) }

    before { expect(subject).to receive(:current_user).and_return(user).exactly(4).times }

    let(:service) { instance_double(EveOnlineCallbackService, name: "Green Black") }

    before do
      #
      # EveOnlineCallbackService.new(current_user, request) # => service
      #
      expect(EveOnlineCallbackService).to receive(:new).with(any_args).and_return(service) # TODO: replace `any_args` with real data
    end

    context "when successful" do
      before { expect(service).to receive(:save!) }

      before { get :show }

      it { is_expected.to respond_with(:found) }

      it { is_expected.to redirect_to("/characters") }

      it { is_expected.to set_flash[:notice].to("Character &laquo;Green Black&raquo; successful added.") }
    end

    context "when service unavailable" do
      before { expect(service).to receive(:save!).and_raise(EveOnline::Exceptions::ServiceUnavailable) }

      before { get :show }

      it { is_expected.to respond_with(:found) }

      it { is_expected.to redirect_to("/characters") }

      it { is_expected.to set_flash[:alert].to("Service Unavailable (503). Please, try again later.") }
    end

    context "when service unavailable" do
      before { expect(service).to receive(:save!).and_raise(EveOnline::Exceptions::InternalServerError) }

      before { get :show }

      it { is_expected.to respond_with(:found) }

      it { is_expected.to redirect_to("/characters") }

      it { is_expected.to set_flash[:alert].to("Internal Server Error (500). Please, try again later.") }
    end

    context "when bad gateway" do
      before { expect(service).to receive(:save!).and_raise(EveOnline::Exceptions::BadGateway) }

      before { get :show }

      it { is_expected.to respond_with(:found) }

      it { is_expected.to redirect_to("/characters") }

      it { is_expected.to set_flash[:alert].to("Bad Gateway (502). Please, try again later.") }
    end

    context "when timeout" do
      before { expect(service).to receive(:save!).and_raise(EveOnline::Exceptions::Timeout) }

      before { get :show }

      it { is_expected.to respond_with(:found) }

      it { is_expected.to redirect_to("/characters") }

      it { is_expected.to set_flash[:alert].to("Timeout Error. Please, try again later.") }
    end
  end
end
