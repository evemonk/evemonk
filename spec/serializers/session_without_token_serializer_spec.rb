require 'rails_helper'

describe SessionWithoutTokenSerializer do
  let!(:session) { create(:session) }

  subject { described_class.new(session) }

  it { should be_a(ActiveModel::Serializer) }

  describe '#as_json' do
    subject { described_class.new(session).as_json }

    its([:id]) { should eq(session.id) }

    its([:name]) { should eq(session.name) }

    its([:device]) { should eq(session.device) }

    its([:created_at]) { should eq(session.created_at.iso8601) }

    its([:updated_at]) { should eq(session.updated_at.iso8601) }
  end
end
