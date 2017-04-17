require 'rails_helper'

describe ApiKeyValidateJob do
  it { should be_a(ApplicationJob) }

  describe '#perform' do
    let(:api_key) { create(:api_key) }

    before do
      #
      # Api::ApiKeyValidate.new(api_key).call
      #
      expect(Api::ApiKeyValidate).to receive(:new).with(api_key) do
        double.tap do |a|
          expect(a).to receive(:call)
        end
      end
    end

    specify { expect { subject.perform(api_key.id) }.not_to raise_error }
  end

  # def perform(api_key_id)
  #   api_key = ApiKey.find(api_key_id)
  #
  #   Api::ApiKeyValidate.new(api_key).call
  # end
  
  
  # describe '#perform' do
  #   let(:api_key_id) { double }
  #
  #   before do
  #     #
  #     # ValidateApiKey.call(api_key_id)
  #     #
  #     expect(ValidateApiKey).to receive(:call).with(api_key_id)
  #   end
  #
  #   specify { expect { subject.perform(api_key_id) }.not_to raise_error }
  # end

end
