# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CorporationPolicy do
  it { expect(subject).to be_an(ApplicationPolicy) }

  let(:user) { build_stubbed(:user) }

  let(:eve_corporation) { build_stubbed(:eve_corporation) }

  subject { described_class.new(user, eve_corporation) }

  context "when user is logged in" do
    let(:user) { create(:user) }

    let(:eve_corporation) { create(:eve_corporation) }

    subject { described_class.new(user, eve_corporation) }

    it { expect(subject).to permit_action(:show) }

    it { expect(subject).to forbid_actions(:index, :create, :new, :update, :edit, :destroy) }
  end

  context "when user is not logged in" do
    let(:user) { nil }

    let(:eve_corporation) { create(:eve_corporation) }

    subject { described_class.new(user, eve_corporation) }

    it { expect(subject).to permit_action(:show) }

    it { expect(subject).to forbid_actions(:index, :create, :new, :update, :edit, :destroy) }
  end

  describe Eve::CorporationPolicy::Scope do
    context "when user is logged in" do
      let!(:user) { create(:user) }

      let!(:eve_corporation) { create(:eve_corporation) }

      subject { described_class.new(user, Eve::Corporation) }

      specify { expect(subject.resolve).to eq([eve_corporation]) }
    end

    context "when user is not logged in" do
      let!(:user) { nil }

      let!(:eve_corporation) { create(:eve_corporation) }

      subject { described_class.new(user, Eve::Corporation) }

      specify { expect(subject.resolve).to eq([eve_corporation]) }
    end
  end
end
