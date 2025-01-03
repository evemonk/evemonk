# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CategoryPolicy do
  it { expect(subject).to be_an(ApplicationPolicy) }

  let(:user) { build_stubbed(:user) }

  let(:eve_category) { build_stubbed(:eve_category) }

  subject { described_class.new(user, eve_category) }

  context "when user is logged in" do
    let(:user) { create(:user) }

    let(:eve_category) { create(:eve_category) }

    subject { described_class.new(user, eve_category) }

    it { expect(subject).to permit_action(:show) }

    it { expect(subject).to forbid_actions(:index, :create, :new, :update, :edit, :destroy) }
  end


  context "when user is not logged in" do
    let(:user) { nil }

    let(:eve_category) { create(:eve_category) }

    subject { described_class.new(user, eve_category) }

    it { expect(subject).to permit_action(:show) }

    it { expect(subject).to forbid_actions(:index, :create, :new, :update, :edit, :destroy) }
  end


  describe Eve::CategoryPolicy::Scope do
    context "when user is logged in" do
      let!(:user) { create(:user) }

      let!(:eve_category) { create(:eve_category) }

      subject { described_class.new(user, Eve::Category) }

      specify { expect(subject.resolve).to eq([eve_category]) }
    end

    context "when user is not logged in" do
      let!(:user) { nil }

      let!(:eve_category) { create(:eve_category) }

      subject { described_class.new(user, Eve::Category) }

      specify { expect(subject.resolve).to eq([eve_category]) }
    end
  end
end
