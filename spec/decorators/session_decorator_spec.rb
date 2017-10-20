# frozen_string_literal: true
require 'rails_helper'

describe SessionDecorator do
  describe '#as_json' do
    let!(:session) { create(:session) }

    context 'with_token: false' do
      subject { session.decorate(context: { with_token: false }).as_json }

      its([:id]) { should eq(session.id) }

      its([:name]) { should eq(session.name) }

      its([:created_at]) { should eq(session.created_at.iso8601) }

      its([:updated_at]) { should eq(session.updated_at.iso8601) }

      its([:token]) { should eq(nil) }

      its([:device]) { should eq(nil) }

      its([:device_token]) { should eq(nil) }
    end

    context 'with_token: true' do
      subject { session.decorate(context: { with_token: true }).as_json }

      its([:id]) { should eq(session.id) }

      its([:name]) { should eq(session.name) }

      its([:created_at]) { should eq(session.created_at.iso8601) }

      its([:updated_at]) { should eq(session.updated_at.iso8601) }

      its([:token]) { should eq(session.token) }

      its([:device]) { should eq(session.device) }

      its([:device_token]) { should eq(session.device_token) }
    end
  end
end
