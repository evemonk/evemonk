# frozen_string_literal: true

require "rails_helper"

describe Auth::EveOnlineSso::CallbacksController do
  it { should be_a(ApplicationController) }

  it { should rescue_from(EveOnline::Exceptions::ServiceUnavailable).with(:handle_service_unavailable) }

  describe "#show" do
    let(:session) { instance_double(Session, token: "token123") }

    let(:form) { instance_double(Api::EveOnlineForm, session: session) }

    before do
      #
      # Api::EveOnlineForm.new(request) => form
      #
      expect(Api::EveOnlineForm).to receive(:new).with(any_args).and_return(form)
    end

    before { expect(form).to receive(:save!) }

    before { get :show }

    it { should respond_with(:found) }

    it { should redirect_to("/autosignin/token123") }
  end

  # private methods

  describe "#handle_service_unavailable" do
    before { expect(subject).to receive(:render).with(inline: "Net::HTTPServiceUnavailable (503). Try again later.") }

    specify { expect { subject.send(:handle_service_unavailable) }.not_to raise_error }
  end
end
