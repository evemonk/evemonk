require 'rails_helper'

describe ApiKey do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }

  it { should validate_presence_of(:key_id) }

  it { should validate_presence_of(:v_code) }

  it { should callback(:validate_api_key).after(:commit).on([:create, :update]) }

  # private methods

  describe '#validate_api_key' do
    subject { stub_model ApiKey, id: 42 }

    before do
      #
      # ValidateApiKeyJob.perform_later(id)
      #
      expect(ValidateApiKeyJob).to receive(:perform_later).with(42)
    end

    specify { expect { subject.send(:validate_api_key) }.not_to raise_error }
  end
end
