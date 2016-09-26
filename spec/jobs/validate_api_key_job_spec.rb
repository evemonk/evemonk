require 'rails_helper'

describe ValidateApiKeyJob do
  it { should be_a(ApplicationJob) }

  describe '#perform' do
    let(:api_key_id) { double }

    before do
      #
      # ValidateApiKey.call(api_key_id)
      #
      expect(ValidateApiKey).to receive(:call).with(api_key_id)
    end

    specify { expect { subject.perform(api_key_id) }.not_to raise_error }
  end
end
