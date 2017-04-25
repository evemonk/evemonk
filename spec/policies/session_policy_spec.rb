require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe SessionPolicy do
  let(:user) { double }

  let(:record) { double }

  subject { described_class.new(user, record) }

  describe '#initialize' do
    its(:user) { should eq(user) }

    its(:record) { should eq(record) }
  end

  describe '#index?' do
    specify { expect(subject.index?).to eq(false) }
  end

  describe '#show?' do
    context 'true' do
      let!(:user) { create(:user) }

      let!(:record) { create(:session, user: user) }

      specify { expect(subject.show?).to eq(true) }
    end

    context 'false' do
      let!(:user) { create(:user) }

      let!(:another_user) { create(:user) }

      let!(:record) { create(:session, user: another_user) }

      specify { expect(subject.show?).to eq(false) }
    end
  end

  describe '#create?' do
    specify { expect(subject.create?).to eq(true) }
  end

  describe '#new?' do
    before { expect(subject).to receive(:create?) }

    specify { expect { subject.new? }.not_to raise_error }
  end

  describe '#update?' do
    before { expect(subject).to receive(:show?) }

    specify { expect { subject.update? }.not_to raise_error }
  end

  describe '#edit?' do
    before { expect(subject).to receive(:show?) }

    specify { expect { subject.edit? }.not_to raise_error }
  end

  describe '#destroy?' do
    before { expect(subject).to receive(:show?) }

    specify { expect { subject.destroy? }.not_to raise_error }
  end

  describe '#scope' do
    before do
      #
      # Pundit.policy_scope!(user, Session)
      #
      expect(Pundit).to receive(:policy_scope!).with(user, Session)
    end

    specify { expect { subject.scope }.not_to raise_error }
  end
end

describe SessionPolicy::Scope do
  let(:user) { double }

  let(:scope) { Session }

  subject { described_class.new(user, scope) }

  describe '#initialize' do
    its(:user) { should eq(user) }

    its(:scope) { should eq(scope) }
  end

  describe '#resolve' do
    let!(:user) { create(:user) }

    let!(:session1) { create(:session, user: user) }

    let!(:session2) { create(:session, user: user) }

    specify { expect(subject.resolve).to eq([session1, session2]) }
  end
end
