# frozen_string_literal: true

require 'rails_helper'

describe SessionDecorator do
  let(:session) { build_stubbed(:session) }

  subject { described_class.new(session) }

  it { should be_a(ApplicationDecorator) }

  describe '#as_json' do
    let(:session) do
      build_stubbed(:session,
                    id: 123,
                    name: 'My Device 1',
                    token: 'token123',
                    device_type: 'ios',
                    device_token: 'push-notification-token-1',
                    created_at: Time.zone.local(2018, 2, 21, 23, 42, 28),
                    updated_at: Time.zone.local(2018, 2, 21, 23, 43, 25))
    end

    context 'without token' do
      subject { session.decorate(context: { with_token: false }).as_json }

      its([:id]) { should eq(123) }

      its([:name]) { should eq('My Device 1') }

      its([:created_at]) { should eq('2018-02-21T23:42:28Z') }

      its([:updated_at]) { should eq('2018-02-21T23:43:25Z') }

      its([:token]) { should eq(nil) }

      its([:device_type]) { should eq(nil) }

      its([:device_token]) { should eq(nil) }
    end

    context 'with token' do
      subject { session.decorate(context: { with_token: true }).as_json }

      its([:id]) { should eq(123) }

      its([:name]) { should eq('My Device 1') }

      its([:created_at]) { should eq('2018-02-21T23:42:28Z') }

      its([:updated_at]) { should eq('2018-02-21T23:43:25Z') }

      its([:token]) { should eq('token123') }

      its([:device_type]) { should eq('ios') }

      its([:device_token]) { should eq('push-notification-token-1') }
    end
  end

  describe '.collection_decorator_class' do
    specify { expect(described_class.collection_decorator_class).to eq(PaginatingDecorator) }
  end
end
