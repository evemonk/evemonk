require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe Api::ApiKeysController do
  it { should be_a(Api::BaseController) }

  it { should use_before_action(:authenticate!) }

  describe '#index.json' do
    context 'authorized' do
      render_views

      let!(:session) { create(:session) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { get :index, format: :json }

      it { should render_template(:index) }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      before { get :index, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end

  describe '#index.html' do
    context 'authorized' do
      render_views

      let!(:session) { create(:session) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { get :index, format: :html }

      it { should respond_with(:not_acceptable) }
    end

    context 'not authorized' do
      before { get :index, format: :html }

      it { should respond_with(:unauthorized) }
    end
  end

  describe '#show.json' do
    context 'authorized' do
      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      let!(:api_key) { create(:api_key, user: user) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { get :show, params: { id: api_key.id }, format: :json }

      it { should render_template(:show) }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      let!(:api_key) { create(:api_key) }

      before { get :show, params: { id: api_key.id }, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end

  describe '#show.html' do
    context 'authorized' do
      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      let!(:api_key) { create(:api_key, user: user) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { get :show, params: { id: api_key.id }, format: :html }

      it { should respond_with(:not_acceptable) }
    end

    context 'not authorized' do
      let!(:api_key) { create(:api_key) }

      before { get :show, params: { id: api_key.id }, format: :html }

      it { should respond_with(:unauthorized) }
    end
  end

  describe '#create.json' do
    context 'authorized' do
      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { post :create, params: { api_key: attributes_for(:api_key) }, format: :json }

      it { should render_template(:create) }

      it { should respond_with(:ok) }
    end

    # context 'not acceptable' do
    #   let!(:user) { create(:user) }
    #
    #   let!(:session) { create(:session, user: user) }
    #
    #   before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }
    #
    #   before { post :create, params: { api_key: attributes_for(:api_key) }, format: :html }
    #
    #   it { should respond_with(:not_acceptable) }
    # end

    context 'not authorized' do
      before { post :create, params: { api_key: attributes_for(:api_key) }, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end

  describe '#update.json' do
    context 'PUT' do
      context 'authorized' do
        let!(:user) { create(:user) }

        let!(:session) { create(:session, user: user) }

        let!(:api_key) { create(:api_key, user: user) }

        before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

        before { put :update, params: { id: api_key.id, api_key: attributes_for(:api_key) }, format: :json }

        it { should render_template(:update) }

        it { should respond_with(:ok) }
      end

      # context 'not acceptable' do
      #   let!(:user) { create(:user) }
      #
      #   let!(:session) { create(:session, user: user) }
      #
      #   let!(:api_key) { create(:api_key, user: user) }
      #
      #   before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }
      #
      #   before { put :update, params: { id: api_key.id, api_key: attributes_for(:api_key) }, format: :html }
      #
      #   it { should respond_with(:not_acceptable) }
      # end

      context 'not authorized' do
        let!(:api_key) { create(:api_key) }

        before { put :update, params: { id: api_key.id }, format: :json }

        it { should respond_with(:unauthorized) }
      end
    end

    context 'PATCH' do
      context 'authorized' do
        let!(:user) { create(:user) }

        let!(:session) { create(:session, user: user) }

        let!(:api_key) { create(:api_key, user: user) }

        before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

        before { patch :update, params: { id: api_key.id, api_key: attributes_for(:api_key) }, format: :json }

        it { should render_template(:update) }

        it { should respond_with(:ok) }
      end

      # context 'not acceptable' do
      #   let!(:user) { create(:user) }
      #
      #   let!(:session) { create(:session, user: user) }
      #
      #   let!(:api_key) { create(:api_key, user: user) }
      #
      #   before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }
      #
      #   before { patch :update, params: { id: api_key.id, api_key: attributes_for(:api_key) }, format: :html }
      #
      #   it { should respond_with(:not_acceptable) }
      # end

      context 'not authorized' do
        let!(:api_key) { create(:api_key) }

        before { patch :update, params: { id: api_key.id }, format: :json }

        it { should respond_with(:unauthorized) }
      end
    end
  end

  describe '#destroy.json' do
    context 'authorized' do
      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      let!(:api_key) { create(:api_key, user: user) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { delete :destroy, params: { id: api_key.id }, format: :json }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      let!(:api_key) { create(:api_key) }

      before { delete :destroy, params: { id: api_key.id }, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end

  describe '#destroy.html' do
    context 'authorized' do
      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      let!(:api_key) { create(:api_key, user: user) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { delete :destroy, params: { id: api_key.id }, format: :html }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      let!(:api_key) { create(:api_key) }

      before { delete :destroy, params: { id: api_key.id }, format: :html }

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
    context '@api_key is set' do
      let(:api_key) { double }

      before { subject.instance_variable_set(:@api_key, api_key) }

      specify { expect(subject.send(:resource)).to eq(api_key) }
    end

    context '@api_key not set' do
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
