require 'rails_helper'

describe ApiKeySerializer do
  let!(:api_key) { create(:api_key) }

  subject { described_class.new(api_key) }

  it { should be_a(ActiveModel::Serializer) }

  describe '#as_json' do
    subject { described_class.new(api_key).as_json }

    its([:id]) { should eq(api_key.id) }

    its([:key_id]) { should eq(api_key.key_id) }

    its([:v_code]) { should eq(api_key.v_code) }

    its([:created_at]) { should eq(api_key.created_at.iso8601) }

    its([:updated_at]) { should eq(api_key.updated_at.iso8601) }
  end
end
