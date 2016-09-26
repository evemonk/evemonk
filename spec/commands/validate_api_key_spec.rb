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

    let(:api_key_info) { double }

    before do
      #
      # EveOnline::Account::ApiKeyInfo.new(api_key.key_id, api_key.v_code)
      #
      expect(EveOnline::Account::ApiKeyInfo).to receive(:new).with(api_key.key_id, api_key.v_code).and_return(api_key_info)
    end

    let(:as_json) { double }

    before { expect(api_key_info).to receive(:as_json).and_return(as_json) }

    before { expect(api_key).to receive(:update!).with(as_json) }

    before { expect(subject).to receive(:broadcast).with(:ok) }

    specify { expect { subject.call }.not_to raise_error }
  end
end
