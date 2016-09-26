require 'rails_helper'

describe ValidateApiKey do
  let(:api_key_id) { double }

  subject { described_class.new(api_key_id) }

  it { should be_a(Rectify::Command) }

  describe '#initialize' do
    its(:api_key_id) { should eq(api_key_id) }
  end

  describe '#call' do
    let(:api_key) { stub_model ApiKey, key_id: 1234567, v_code: 'abc' }

    before { expect(ApiKey).to receive(:find).with(api_key_id).and_return(api_key) }

    let(:json) { double }

    before do
      #
      # EveOnline::Account::ApiKeyInfo.new(api_key.key_id, api_key.v_code).as_json => json
      #
      expect(EveOnline::Account::ApiKeyInfo).to receive(:new).with(api_key.key_id, api_key.v_code) do
        double.tap do |a|
          expect(a).to receive(:as_json).and_return(json)
        end
      end
    end

    before { expect(api_key).to receive(:update_columns).with(json) }

    before { expect(subject).to receive(:broadcast).with(:ok) }

    specify { expect { subject.call }.not_to raise_error }
  end
end
