# frozen_string_literal: true

require 'rails_helper'

describe UserDecorator do
  let(:user) { build_stubbed(:user) }

  subject { described_class.new(user) }

  it { should be_a(ApplicationDecorator) }

  describe '#as_json' do
    let(:user) do
      build_stubbed(:user,
                    id: 42,
                    email: 'me@example.com',
                    created_at: Time.zone.local(2018, 2, 21, 23, 42, 28),
                    updated_at: Time.zone.local(2018, 2, 21, 23, 43, 25))
    end

    subject { user.decorate.as_json }

    its([:id]) { should eq(42) }

    its([:email]) { should eq('me@example.com') }

    its([:created_at]) { should eq('2018-02-21T23:42:28Z') }

    its([:updated_at]) { should eq('2018-02-21T23:43:25Z') }
  end
end
