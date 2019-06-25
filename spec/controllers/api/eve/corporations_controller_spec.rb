# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::CorporationsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe '#index' do
    context 'with supported content type' do
      let(:scoped_eve_corporation) { instance_double(Eve::Corporation) }

      before do
        expect(subject).to receive(:policy_scope).with(::Eve::Corporation)
                                                 .and_return(scoped_eve_corporation)
      end

      before do
        #
        # Eve::CorporationsSearcher.new(params[:q], policy_scope(::Eve::Corporation))
        #                          .search
        #                          .page(params[:page])
        #
        expect(Eve::CorporationsSearcher).to receive(:new).with('search string', scoped_eve_corporation) do
          double.tap do |a|
            expect(a).to receive(:search) do
              double.tap do |b|
                expect(b).to receive(:page).with('1')
              end
            end
          end
        end
      end

      before { subject.instance_variable_set(:@_pundit_policy_scoped, true) }

      before { get :index, params: { format: :json, page: '1', q: 'search string' } }

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
      let(:eve_corporation) { instance_double(Eve::Corporation) }

      before { expect(Eve::Corporation).to receive(:find_by!).with(corporation_id: '98005120').and_return(eve_corporation) }

      before { expect(subject).to receive(:authorize).with(eve_corporation) }

      before { subject.instance_variable_set(:@_pundit_policy_authorized, true) }

      before { get :show, params: { id: '98005120', format: :json } }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context 'when not supported accept type' do
      before { get :show, params: { id: '98005120', format: :html } }

      it { should respond_with(:not_acceptable) }
    end

    context 'when corporation not found' do
      before { expect(Eve::Corporation).to receive(:find_by!).with(corporation_id: '98005120').and_raise(ActiveRecord::RecordNotFound) }

      before { get :show, params: { id: '98005120', format: :json } }

      it { should respond_with(:not_found) }
    end
  end
end
