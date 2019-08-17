# frozen_string_literal: true

require "rails_helper"

describe Eve::ServerStatusPolicy do
  let!(:user) { create(:user) }

  let!(:record) { create(:eve_server_status) }

  describe "#initialize" do
    subject { described_class.new(user, record) }

    its(:user) { should eq(user) }

    its(:record) { should eq(record) }
  end

  describe "#index?" do
    subject { described_class.new(user, record) }

    specify { expect(subject.index?).to eq(false) }
  end

  describe "#show?" do
    subject { described_class.new(user, record) }

    specify { expect(subject.show?).to eq(true) }
  end

  describe "#create?" do
    let!(:record) { build(:eve_type) }

    subject { described_class.new(user, record) }

    specify { expect(subject.create?).to eq(true) }
  end

  describe "#update?" do
    subject { described_class.new(user, record) }

    specify { expect(subject.update?).to eq(true) }
  end

  describe "#destroy?" do
    subject { described_class.new(user, record) }

    specify { expect(subject.destroy?).to eq(true) }
  end

  describe "#scope" do
    subject { described_class.new(user, record) }

    before do
      #
      # Pundit.policy_scope!(user, record.class)
      #
      expect(Pundit).to receive(:policy_scope!).with(user, Eve::ServerStatus)
    end

    specify { expect { subject.scope }.not_to raise_error }
  end
end

describe Eve::ServerStatusPolicy::Scope do
  describe "initialize" do
    let(:user) { double }

    let(:scope) { double }

    subject { described_class.new(user, scope) }

    its(:user) { should eq(user) }

    its(:scope) { should eq(scope) }
  end

  describe "#resolve" do
    let!(:user) { create(:user) }

    let!(:record) { create(:eve_server_status) }

    subject { described_class.new(user, Eve::ServerStatus) }

    before { expect(Eve::ServerStatus).to receive(:all) }

    specify { expect { subject.resolve }.not_to raise_error }
  end
end
