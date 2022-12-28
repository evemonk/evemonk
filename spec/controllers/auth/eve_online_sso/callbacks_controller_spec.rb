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

    before { expect(service).to receive(:save!) }

    before { get :show }

    it { should respond_with(:found) }

    it { should redirect_to("/characters") }
  end

  # private methods

  describe "#handle_service_unavailable" do
    before { expect(subject).to receive(:render).with({inline: "Service Unavailable (503). Please, try again later."}) }

    specify { expect { subject.send(:handle_service_unavailable) }.not_to raise_error }
  end

  describe "#handle_internal_server_error" do
    before { expect(subject).to receive(:render).with({inline: "Internal Server Error (500). Please, try again later."}) }

    specify { expect { subject.send(:handle_internal_server_error) }.not_to raise_error }
  end

  describe "#handle_bad_gateway" do
    before { expect(subject).to receive(:render).with({inline: "Bad Gateway (502). Please, try again later."}) }

    specify { expect { subject.send(:handle_bad_gateway) }.not_to raise_error }
  end

  describe "#handle_timeout" do
    before { expect(subject).to receive(:render).with({inline: "Timeout Error. Please, try again later."}) }

    specify { expect { subject.send(:handle_timeout) }.not_to raise_error }
  end
end
