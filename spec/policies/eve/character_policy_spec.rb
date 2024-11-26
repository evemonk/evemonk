# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CharacterPolicy do
  it { expect(subject).to be_an(ApplicationPolicy) }

  let(:user) { build_stubbed(:user) }

  let(:eve_character) { build_stubbed(:eve_character) }

  subject { described_class.new(user, eve_character) }

  context "when user is logged in" do
    let(:user) { create(:user) }

    let(:eve_character) { create(:eve_character) }

    subject { described_class.new(user, eve_character) }

    it { expect(subject).to permit_action(:show) }

    it { expect(subject).to forbid_actions(:index, :create, :new, :update, :edit, :destroy) }
  end

  context "when user is not logged in" do
    let(:user) { nil }

    let(:eve_character) { create(:eve_character) }

    subject { described_class.new(user, eve_character) }

    it { expect(subject).to permit_action(:show) }

    it { expect(subject).to forbid_actions(:index, :create, :new, :update, :edit, :destroy) }
  end

  describe Eve::CharacterPolicy::Scope do
    context "when user is logged in" do
      let!(:user) { create(:user) }

      let!(:eve_character) { create(:eve_character) }

      subject { described_class.new(user, Eve::Character) }

      specify { expect(subject.resolve).to eq([eve_character]) }
    end

    context "when user is not logged in" do
      let!(:user) { nil }

      let!(:eve_character) { create(:eve_character) }

      subject { described_class.new(user, Eve::Character) }

      specify { expect(subject.resolve).to eq([eve_character]) }
    end
  end
end
