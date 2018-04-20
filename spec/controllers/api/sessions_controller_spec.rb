# frozen_string_literal: true

require 'rails_helper'

module Api
  describe SessionsController do
    it { should be_a(Api::BaseController) }

    it { should use_before_action(:authenticate!) }

    describe '#index' do
      context 'when user signed in' do
        let(:sessions) { double }

        before { sign_in }

        before do
          #
          # subject.policy_scope(Session).order(created_at: :asc)
          #                              .page(params[:page])
          #
          expect(subject).to receive(:policy_scope).with(Session) do
            double.tap do |a|
              expect(a).to receive(:order).with(created_at: :asc) do
                double.tap do |b|
                  expect(b).to receive(:page).with('1')
                                             .and_return(sessions)
                end
              end
            end
          end
        end

        before { expect(SessionDecorator).to receive(:decorate_collection).with(sessions) }

        before { get :index, params: { format: :json, page: '1' } }

        it { should respond_with(:ok) }
      end

      context 'when user not signed in' do
        before { get :index, params: { format: :json } }

        it { should respond_with(:unauthorized) }
      end

      context 'when not supported accept type' do
        before { sign_in }

        before { get :index, params: { format: :html } }

        it { should respond_with(:not_acceptable) }
      end
    end
  end
end
