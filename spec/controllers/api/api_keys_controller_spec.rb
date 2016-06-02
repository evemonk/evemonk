require 'rails_helper'

describe Api::ApiKeysController do
  it { should be_a Api::BaseController }

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

    let(:current_user) { double }

    before { expect(subject).to receive(:params).and_return(params) }

    before { expect(subject).to receive(:current_user).and_return(current_user) }

    before do
      #
      # current_user.api_keys.find(42)
      #
      expect(current_user).to receive(:api_keys) do
        double.tap do |a|
          expect(a).to receive(:find).with('42')
        end
      end
    end

    specify { expect { subject.send(:resource) }.not_to raise_error }
  end

  describe '#collection' do
    let(:current_user) { double }

    before { expect(subject).to receive(:current_user).and_return(current_user) }

    before do
      #
      # current_user.api_keys.order(created_at: :asc)
      #
      expect(current_user).to receive(:api_keys) do
        double.tap do |a|
          expect(a).to receive(:order).with(created_at: :asc)
        end
      end
    end

    specify { expect { subject.send(:collection) }.not_to raise_error }
  end
end
