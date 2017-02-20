require 'rails_helper'

describe SessionPolicy do # rubocop:disable Metrics/BlockLength
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
    let(:record) { stub_model Session, id: 1234 }

    before do
      #
      # subject.scope.where(id: record.id).exists?
      #
      expect(subject).to receive(:scope) do
        double.tap do |a|
          expect(a).to receive(:where).with(id: record.id) do
            double.tap do |b|
              expect(b).to receive(:exists?)
            end
          end
        end
      end
    end

    specify { expect { subject.show? }.not_to raise_error }
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

  let(:scope) { double }

  subject { described_class.new(user, scope) }

  describe '#initialize' do
    its(:user) { should eq(user) }

    its(:scope) { should eq(scope) }
  end

  describe '#resolve' do
    before do
      #
      # subject.scope.where(user: user)
      #
      expect(subject).to receive(:scope) do
        double.tap do |a|
          expect(a).to receive(:where).with(user: user).and_return(scope)
        end
      end
    end

    specify { expect(subject.resolve).to eq(scope) }
  end
end
