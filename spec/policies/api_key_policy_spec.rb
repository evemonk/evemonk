require 'rails_helper'

describe ApiKeyPolicy do
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
    let(:record) { stub_model ApiKey, id: 42 }

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
      # Pundit.policy_scope!(user, ApiKey)
      #
      expect(Pundit).to receive(:policy_scope!).with(user, ApiKey)
    end

    specify { expect { subject.scope }.not_to raise_error }
  end
end

describe ApiKeyPolicy::Scope do
  #   class Scope
  #     attr_reader :user, :scope
  #
  #     def initialize(user, scope)
  #       @user = user
  #       @scope = scope
  #     end
  #
  #     def resolve
  #       scope.where(user: user)
  #     end
  #   end
  # end
end
