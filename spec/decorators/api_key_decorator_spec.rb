require 'rails_helper'

describe ApiKeyDecorator do
  describe '#as_json' do
    let!(:api_key) { create(:api_key) }

    subject { api_key.decorate.as_json }

    its([:id]) { should eq(api_key.id) }

    its([:key_id]) { should eq(api_key.key_id) }

    its([:v_code]) { should eq(api_key.v_code) }

    its([:created_at]) { should eq(api_key.created_at.iso8601) }

    its([:updated_at]) { should eq(api_key.updated_at.iso8601) }
  end
end
