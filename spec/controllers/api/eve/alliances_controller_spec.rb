# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::AlliancesController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe '#index' do
    context 'with supported content type' do
      before do
        #
        # Eve::Alliance.includes(:faction, :creator_corporation, :creator, :executor_corporation)
        #              .page(params[:page])
        #
        expect(Eve::Alliance).to receive(:includes).with(:faction, :creator_corporation, :creator, :executor_corporation) do
          double.tap do |a|
            expect(a).to receive(:page).with('1')
          end
        end
      end

      before { subject.instance_variable_set(:@_pundit_policy_scoped, true) }

      before { get :index, params: { format: :json, page: '1' } }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context 'when not supported accept type' do
      before { get :index, params: { format: :html } }

      it { should respond_with(:not_acceptable) }
    end
  end

  describe '#show' do
    context 'with supported content type' do
      before { expect(Eve::Alliance).to receive(:find_by!).with(alliance_id: '99005443') }

      before { subject.instance_variable_set(:@_pundit_policy_authorized, true) }

      before { get :show, params: { id: '99005443', format: :json } }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context 'when not supported accept type' do
      before { get :show, params: { id: '99005443', format: :html } }

      it { should respond_with(:not_acceptable) }
    end
  end
end
