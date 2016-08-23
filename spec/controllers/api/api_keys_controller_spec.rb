require 'rails_helper'

describe Api::ApiKeysController do
  it { should be_a Api::BaseController }

  describe '#index' do
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

    before { expect(subject).to receive(:resource_params).and_return(resource_params) }

    before { expect(subject).to receive(:current_user).and_return(current_user) }

    before do
      #
      # current_user.api_keys.build(resource_params)
      #
      expect(current_user).to receive(:api_keys) do
        double.tap do |a|
          expect(a).to receive(:build).with(resource_params)
        end
      end
    end

    specify { expect { subject.send(:build_resource) }.not_to raise_error }
  end

  describe '#resource' do
    let(:params) { { id: '42' } }

    before { expect(subject).to receive(:params).and_return(params) }

    before do
      #
      # ApiKey.find(params[:id])
      #
      expect(ApiKey).to receive(:find).with(params[:id])
    end

    specify { expect { subject.send(:resource) }.not_to raise_error }
  end

  describe '#collection' do
    before do
      #
      # subject.policy_scope(ApiKey).order(created_at: :asc).page(params[:page])
      #
      expect(subject).to receive(:policy_scope).with(ApiKey) do
        double.tap do |a|
          expect(a).to receive(:order).with(created_at: :asc) do
            double.tap do |b|
              expect(b).to receive(:page).with(nil)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:collection) }.not_to raise_error }
  end
end
