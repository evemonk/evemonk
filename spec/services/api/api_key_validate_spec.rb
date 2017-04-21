require 'rails_helper'

describe Api::ApiKeyValidate do
  let(:api_key) { double }

  subject { described_class.new(api_key) }

  describe '#initialize' do
    its(:api_key) { should eq(api_key) }
  end

  describe '#call' do
    specify { expect { subject.call }.not_to raise_error }
  end
end
