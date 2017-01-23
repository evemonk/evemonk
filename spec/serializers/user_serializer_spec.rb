require 'rails_helper'

describe UserSerializer do
  let!(:user) { create(:user) }

  subject { described_class.new(user) }

  it { should be_a(ActiveModel::Serializer) }

  describe '#as_json' do
    subject { described_class.new(user).as_json }

    its([:id]) { should eq(user.id) }

    its([:email]) { should eq(user.email) }

    its([:created_at]) { should eq(user.created_at.iso8601) }

    its([:updated_at]) { should eq(user.updated_at.iso8601) }
  end
end
