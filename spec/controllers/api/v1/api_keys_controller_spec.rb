require 'rails_helper'

describe Api::V1::ApiKeysController do
  it { should be_a(Api::V1::BaseController) }

  it { should use_before_action(:authenticate) }

  describe '#index.json' do
    context 'authorized' do
      before { expect(subject).to receive(:verify_policy_scoped).and_return(true) }

      before { sign_in }

      before { get :index, format: :json }

      it { should render_template(:index) }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      before { get :index, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end

  describe '#show.json' do
    context 'authorized' do
      before { expect(subject).to receive(:verify_authorized).and_return(true) }

      let(:api_key) { double }

      before { expect(subject).to receive(:resource).and_return(api_key) }

      before { expect(subject).to receive(:authorize).with(api_key) }

      before { sign_in }

      before { get :show, params: { id: '42' }, format: :json }

      it { should render_template(:show) }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      before { get :show, params: { id: '42' }, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end

  describe '#create.json' do
    context 'authorized' do
      before { expect(subject).to receive(:verify_authorized).and_return(true) }

      let(:api_key) { double }

      let(:params) { { api_key: { key_id: '1234567', v_code: 'abc' } } }

      before do
        #
        # subject.current_user.api_keys.build(params) => api_key
        #
        expect(subject).to receive(:current_user) do
          double.tap do |a|
            expect(a).to receive(:api_keys) do
              double.tap do |b|
                expect(b).to receive(:build).with(permit!(params[:api_key])).and_return(api_key)
              end
            end
          end
        end
      end

      before { expect(subject).to receive(:authorize).with(api_key) }

      before { expect(api_key).to receive(:save!) }

      before { sign_in }

      before { post :create, params: params, format: :json }

      it { should render_template(:create) }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      before { post :create, params: { api_key: { key_id: '1234567', v_code: 'abc' } }, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end

  describe '#update.json' do
    context 'PUT' do
      context 'authorized' do
        before { expect(subject).to receive(:verify_authorized).and_return(true) }

        let(:api_key) { double }

        let(:params) { { id: '42', api_key: { key_id: '1234567', v_code: 'abc' } } }

        before { subject.instance_variable_set(:@api_key, api_key) }

        before { expect(subject).to receive(:authorize).with(api_key) }

        before { expect(api_key).to receive(:update!).with(permit!(params[:api_key])) }

        before { sign_in }

        before { put :update, params: params, format: :json }

        it { should render_template(:update) }

        it { should respond_with(:ok) }
      end

      context 'not authorized' do
        before { put :update, params: { id: '42' }, format: :json }

        it { should respond_with(:unauthorized) }
      end
    end

    context 'PATCH' do
      context 'authorized' do
        before { expect(subject).to receive(:verify_authorized).and_return(true) }

        let(:api_key) { double }

        let(:params) { { id: '42', api_key: { key_id: '1234567', v_code: 'abc' } } }

        before { subject.instance_variable_set(:@api_key, api_key) }

        before { expect(subject).to receive(:authorize).with(api_key) }

        before { expect(api_key).to receive(:update!).with(permit!(params[:api_key])) }

        before { sign_in }

        before { patch :update, params: params, format: :json }

        it { should render_template(:update) }

        it { should respond_with(:ok) }
      end

      context 'not authorized' do
        before { patch :update, params: { id: '42' }, format: :json }

        it { should respond_with(:unauthorized) }
      end
    end
  end

  describe '#destroy.json' do
    context 'authorized' do
      before { expect(subject).to receive(:verify_authorized).and_return(true) }

      let(:api_key) { double }

      before { expect(subject).to receive(:resource).and_return(api_key).twice }

      before { expect(subject).to receive(:authorize).with(api_key) }

      before { expect(api_key).to receive(:destroy!) }

      before { sign_in }

      before { delete :destroy, params: { id: '42' }, format: :json }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      before { delete :destroy, params: { id: '42' }, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end

  # private methods

  describe '#resource_params' do
    before do
      #
      # subject.params.require(:api_key).permit(:key_id, :v_code)
      #
      expect(subject).to receive(:params) do
        double.tap do |a|
          expect(a).to receive(:require).with(:api_key) do
            double.tap do |b|
              expect(b).to receive(:permit).with(:key_id, :v_code)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:resource_params) }.not_to raise_error }
  end

  describe '#build_resource' do
    let(:resource_params) { double }

    let(:current_user) { double }

    let(:api_key) { double }

    before { expect(subject).to receive(:resource_params).and_return(resource_params) }

    before { expect(subject).to receive(:current_user).and_return(current_user) }

    before do
      #
      # current_user.api_keys.build(resource_params) => api_key
      #
      expect(current_user).to receive(:api_keys) do
        double.tap do |a|
          expect(a).to receive(:build).with(resource_params).and_return(api_key)
        end
      end
    end

    specify { expect { subject.send(:build_resource) }.not_to raise_error }

    specify { expect { subject.send(:build_resource) }.to change { subject.instance_variable_get(:@api_key) }.from(nil).to(api_key) }
  end

  describe '#resource' do
    context '@resource is set' do
      let(:api_key) { double }

      before { subject.instance_variable_set(:@api_key, api_key) }

      specify { expect(subject.send(:resource)).to eq(api_key) }
    end

    context '@resource not set' do
      let(:api_key) { double }

      let(:params) { { id: '42' } }

      before { expect(subject).to receive(:params).and_return(params) }

      before do
        #
        # ApiKey.find(params[:id]) => api_key
        #
        expect(ApiKey).to receive(:find).with(params[:id]).and_return(api_key)
      end

      specify { expect { subject.send(:resource) }.not_to raise_error }

      specify { expect { subject.send(:resource) }.to change { subject.instance_variable_get(:@api_key) }.from(nil).to(api_key) }
    end
  end

  describe '#collection' do
    context '@api_keys is set' do
      let(:api_keys) { double }

      before { subject.instance_variable_set(:@api_keys, api_keys) }

      specify { expect(subject.send(:collection)).to eq(api_keys) }
    end

    context '@api_keys not set' do
      let(:api_keys) { double }

      before do
        #
        # subject.policy_scope(ApiKey).order(created_at: :asc).page(params[:page]) => api_keys
        #
        expect(subject).to receive(:policy_scope).with(ApiKey) do
          double.tap do |a|
            expect(a).to receive(:order).with(created_at: :asc) do
              double.tap do |b|
                expect(b).to receive(:page).with(nil).and_return(api_keys)
              end
            end
          end
        end
      end

      specify { expect { subject.send(:collection) }.not_to raise_error }

      specify { expect { subject.send(:collection) }.to change { subject.instance_variable_get(:@api_keys) }.from(nil).to(api_keys) }
    end
  end
end
