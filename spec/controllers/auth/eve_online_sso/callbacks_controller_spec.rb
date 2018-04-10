# frozen_string_literal: true

require 'rails_helper'

describe Auth::EveOnlineSso::CallbacksController do
  it { should be_a(ApplicationController) }

  describe '#show' do
    let(:eve_online) { double }

    before do
      #
      # Api::EveOnline.new(request) => eve_online
      #
      expect(Api::EveOnline).to receive(:new).with(any_args).and_return(eve_online)
    end

    before { expect(eve_online).to receive(:save!) }

    let(:token) { double }

    before do
      #
      # eve_online.session.token => token
      #
      expect(eve_online).to receive(:session) do
        double.tap do |a|
          expect(a).to receive(:token).and_return(token)
        end
      end
    end

    before do
      #
      # subject.cookies['auth_token'] = eve_online.session.token
      #
      expect(subject).to receive(:cookies) do
        double.tap do |a|
          expect(a).to receive(:[]=).with('auth_token', token)
        end
      end
    end

    before { get :show }

    it { should respond_with(:found) }
  end
end
