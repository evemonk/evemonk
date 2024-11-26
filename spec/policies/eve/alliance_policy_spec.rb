# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AlliancePolicy do
  it { expect(subject).to be_an(ApplicationPolicy) }

  let(:user) { build_stubbed(:user) }

  let(:eve_alliance) { build_stubbed(:eve_alliance) }

  subject { described_class.new(user, eve_alliance) }

  context "when user is logged in" do
    let(:user) { create(:user) }

    let(:eve_alliance) { create(:eve_alliance) }

    subject { described_class.new(user, eve_alliance) }

    it { expect(subject).to permit_action(:show) }

    it { expect(subject).to forbid_actions(:index, :create, :new, :update, :edit, :destroy) }
  end

  context "when user is not logged in" do
    let(:user) { nil }

    let(:eve_alliance) { create(:eve_alliance) }

    subject { described_class.new(user, eve_alliance) }

    it { expect(subject).to permit_action(:show) }

    it { expect(subject).to forbid_actions(:index, :create, :new, :update, :edit, :destroy) }
  end

  describe Eve::AlliancePolicy::Scope do
    context "when user is logged in" do
      let!(:user) { create(:user) }

      let!(:eve_alliance) { create(:eve_alliance) }

      subject { described_class.new(user, Eve::Alliance) }

      specify { expect(subject.resolve).to eq([eve_alliance]) }
    end

    context "when user is not logged in" do
      let!(:user) { nil }

      let!(:eve_alliance) { create(:eve_alliance) }

      subject { described_class.new(user, Eve::Alliance) }

      specify { expect(subject.resolve).to eq([eve_alliance]) }
    end
  end
end
