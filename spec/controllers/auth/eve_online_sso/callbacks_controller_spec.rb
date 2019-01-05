# frozen_string_literal: true

require 'rails_helper'

describe Auth::EveOnlineSso::CallbacksController do
  it { should be_a(ApplicationController) }

  describe '#show' do
    let(:session) { instance_double(Session, token: 'token123') }

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

    it { should redirect_to('/autosignin/token123') }
  end
end
