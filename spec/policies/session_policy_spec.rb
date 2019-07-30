# frozen_string_literal: true

require "rails_helper"

describe SessionPolicy do
  let!(:user) { create(:user) }

  let!(:record) { create(:session, user: user) }

  let!(:another_user) { create(:user) }

  describe "#initialize" do
    let(:user) { double }

    let(:record) { double }

    subject { described_class.new(user, record) }

    its(:user) { should eq(user) }

    its(:record) { should eq(record) }
  end

  describe "#index?" do
    let(:user) { double }

    let(:record) { double }

    subject { described_class.new(user, record) }

    specify { expect(subject.index?).to eq(false) }
  end

  describe "#show?" do
    context "when character owner" do
      subject { described_class.new(user, record) }

      specify { expect(subject.show?).to eq(true) }
    end

    context "when another user" do
      subject { described_class.new(another_user, record) }

      specify { expect(subject.show?).to eq(false) }
    end
  end

  describe "#create?" do
    let!(:record) { build(:session, user: user) }

    subject { described_class.new(user, record) }

    specify { expect(subject.create?).to eq(true) }
  end

  describe "#update?" do
    context "when character owner" do
      subject { described_class.new(user, record) }

      specify { expect(subject.update?).to eq(true) }
    end

    context "when another user" do
      subject { described_class.new(another_user, record) }

      specify { expect(subject.update?).to eq(false) }
    end
  end

  describe "#destroy?" do
    context "when character owner" do
      subject { described_class.new(user, record) }

      specify { expect(subject.destroy?).to eq(true) }
    end

    context "when another user" do
      subject { described_class.new(another_user, record) }

      specify { expect(subject.destroy?).to eq(false) }
    end
  end

  describe "#scope" do
    subject { described_class.new(user, record) }

    before do
      #
      # Pundit.policy_scope!(user, record.class)
      #
      expect(Pundit).to receive(:policy_scope!).with(user, Session)
    end

    specify { expect { subject.scope }.not_to raise_error }
  end
end

describe SessionPolicy::Scope do
  describe "initialize" do
    let(:user) { double }

    let(:scope) { double }

    subject { described_class.new(user, scope) }

    its(:user) { should eq(user) }

    its(:scope) { should eq(scope) }
  end

  describe "#resolve" do
    let!(:user) { create(:user) }

    let!(:record) { create(:session, user: user) }

    let!(:another_user) { create(:user) }

    context "when owner" do
      subject { described_class.new(user, Session) }

      specify { expect(subject.resolve.all).to eq([record]) }
    end

    context "when another other" do
      subject { described_class.new(another_user, Session) }

      specify { expect(subject.resolve.all).to eq([]) }
    end
  end
end
