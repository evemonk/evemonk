require 'rails_helper'

describe UserPolicy do
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
      let(:user) { stub_model User, id: 42 }

      let(:record) { stub_model User, id: 42 }

      specify { expect(subject.show?).to eq(true) }
    end

    context 'false' do
      let(:user) { stub_model User, id: 1 }

      let(:record) { stub_model User, id: 42 }

      specify { expect(subject.show?).to eq(false) }
    end
  end

  describe '#create?' do
    specify { expect(subject.create?).to eq(false) }
  end

  describe '#new?' do
    specify { expect(subject.new?).to eq(false) }
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
      # Pundit.policy_scope!(user, User)
      #
      expect(Pundit).to receive(:policy_scope!).with(user, User)
    end

    specify { expect { subject.scope }.not_to raise_error }
  end
end

describe UserPolicy::Scope do
  let(:user) { double }

  let(:scope) { double }

  subject { described_class.new(user, scope) }

  describe '#initialize' do
    its(:user) { should eq(user) }

    its(:scope) { should eq(scope) }
  end

  describe '#resolve' do
    let(:user) { stub_model User, id: 42 }

    before do
      #
      # subject.scope.where(id: user.id)
      #
      expect(subject).to receive(:scope) do
        double.tap do |a|
          expect(a).to receive(:where).with(id: user.id).and_return(scope)
        end
      end
    end

    specify { expect(subject.resolve).to eq(scope) }
  end
end
