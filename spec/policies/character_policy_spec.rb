# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterPolicy do
  context "when user is not logged in" do
    let(:user) { nil }

    let(:character) { create(:character) }

    subject { described_class.new(user, character) }

    it { expect(subject).to forbid_all_actions }
  end

  context "when user is logged in" do
    context "when user is own character" do
      let(:user) { create(:user) }

      let(:character) { create(:character, user: user) }

      subject { described_class.new(user, character) }

      it { expect(subject).to forbid_action(:index) }

      it { expect(subject).to permit_actions(:show, :create, :new, :update, :edit, :destroy) }
    end

    context "when user is not own character" do
      let(:user) { create(:user) }

      let(:character) { create(:character) }

      subject { described_class.new(user, character) }

      it { expect(subject).to forbid_action(:index) }

      it { expect(subject).to permit_actions(:create, :new) }

      it { expect(subject).to forbid_actions(:show, :update, :edit, :destroy) }
    end
  end

  describe CharacterPolicy::Scope do
    context "when user is logged in" do
      context "when user is own character" do
        let!(:user) { create(:user) }

        let!(:character) { create(:character, user: user) }

        subject { described_class.new(user, Character) }

        specify { expect(subject.resolve).to eq([character]) }
      end

      context "when user is not own character" do
        let!(:user) { create(:user) }

        let!(:character) { create(:character) }

        subject { described_class.new(user, Character) }

        specify { expect(subject.resolve).to eq([]) }
      end
    end

    context "when user is not logged in" do
      let!(:user) { nil }

      let!(:character) { create(:character) }

      subject { described_class.new(user, Character) }

      specify { expect(subject.resolve).to eq([]) }
    end
  end
end
