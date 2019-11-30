# frozen_string_literal: true

require "rails_helper"

describe Api::EndAllUserSessions do
  describe "#initialize" do
    let(:user) { instance_double(User) }

    subject { described_class.new(user) }

    its(:user) { should eq(user) }
  end

  describe "#execute" do
    let!(:user) { create(:user) }

    let!(:session1) { create(:session, user: user) }

    let!(:session2) { create(:session, user: user) }

    let!(:session3) { create(:session, user: user) }

    subject { described_class.new(user) }

    specify { expect { subject.execute }.to change { user.sessions.count }.from(3).to(0) }
  end
end
